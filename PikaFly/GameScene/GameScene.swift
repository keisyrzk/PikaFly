import SpriteKit
import GameplayKit

protocol SceneDelegate {
    func distanceDidChange(distance: String)
    func gameShouldStart()
    func pikachuDidStart()
    func pikachuDidStop(isTeamR: Bool)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    enum GameStartState {
        case Started
        case ChooseAngle
        case ChoosePower
        case Launched
    }
    
    let worldNode = SKNode()
    
    let pikachu = SKSpriteNode(imageNamed: "pikachuDischarged")
    var isPikachuCharged = false {
        didSet {
            pikachu.texture = isPikachuCharged ? SKTexture(image: #imageLiteral(resourceName: "pikachuCharged")) : SKTexture(image: #imageLiteral(resourceName: "pikachuDischarged"))
        }
    }
    
    var pokeThrower = SKSpriteNode()
    var obstacles: [Obstacle] = []
    var pokemons: [Pokemon] = []
    var cam: SKCameraNode!
    
    var gameStartedState: GameStartState = .Started
    
    let gameModel = GameModel()
    var sceneDelegate: SceneDelegate? = nil
    
    var isAnimationLaunched = false
    
    
    override func didMove(to view: SKView) {
        
        addChild(worldNode)
        
        setupCamera()
        setupPikachu()
        setupPhysics()
        
        generateObstacles()
        generatePokemons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch gameStartedState {
            
        case .Started:
            
            setupPokeThrower()
            
            sceneDelegate?.pikachuDidStart()
            
            let launcher = Launcher.createLaucher(from: pokeThrower.position)
            worldNode.addChild(launcher)
            launcher.run(Launcher.getAngleAction())
            
            gameStartedState = .ChooseAngle
            
        case .ChooseAngle:
            
            if let launcherNode = worldNode.children.last {
                gameModel.getAngle(from: launcherNode.zRotation)
                gameModel.getDisplacement()

                launcherNode.removeAllActions()
                launcherNode.run(Launcher.getPowerAction())
            }
        
            gameStartedState = .ChoosePower
            
        case .ChoosePower:
            
            if let launcherNode = worldNode.children.last {
                
                gameModel.getPower(nodeFrame: launcherNode.frame)
                launcherNode.removeFromParent()
            }
            
            gameStartedState = .Launched
            
            pokeThrower.removeAllActions()
            if let pokeThrow_start = SKAction(named: "PokeThrow_throw") {
                pokeThrower.run(pokeThrow_start) {
                    self.physicsWorld.gravity = CGVector(dx:0 , dy: -9.8)
                    self.pikachu.physicsBody?.applyImpulse(CGVector(dx: self.gameModel.dx * self.gameModel.power,
                                                                    dy: self.gameModel.dy * self.gameModel.power))
                    self.pikachu.isHidden = false
                }
            }
            
        default:
            gameStartedState = .Started
            sceneDelegate?.gameShouldStart()
        }
    }
    
    // a way to add new sprites in a loop
    override func didSimulatePhysics() {

        if pikachu.position.x >= self.frame.width/2 {
            if pikachu.position.y < self.frame.height/2 {
                cam.position = CGPoint(x: pikachu.position.x, y: self.frame.height/2)
            }
            else {
                cam.position = pikachu.position
            }
        }
        
        let distance = Int(pikachu.position.x) - Int(gameModel.pikachuPosition)
        let pikachuDidStop = abs(Int32(pikachu.physicsBody!.velocity.dx)) < 5 && abs(Int32(pikachu.physicsBody!.velocity.dy)) < 5
        sceneDelegate?.distanceDidChange(distance: "\(distance > 0 ? distance : 0)m")
        
        if pikachu.physicsBody!.velocity.dx > 2500 {
            isPikachuCharged = true
        }
        
        if pikachuDidStop && distance > 0 {
            sceneDelegate?.pikachuDidStop(isTeamR: false)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let secondNode = contact.bodyB.node as! SKSpriteNode
        
        if (contact.bodyA.categoryBitMask == Bits.pikachuCategory) && (contact.bodyB.categoryBitMask == Bits.teamRCategory) {
            
            //            let contactPoint = contact.contactPoint
            //            let contact_y = contactPoint.y
            //            let target_y = secondNode.position.y
            //            let margin = secondNode.frame.size.height/2 - 25
            
            if isPikachuCharged {
                if let node = contact.bodyB.node {
                    isAnimationLaunched = true
                    node.removeFromParent()
                    self.isPikachuCharged = false
                    worldNode.isPaused = true
                    physicsWorld.speed = 0
                    
                    if let action = SKAction(named: "TeamRBlastOffAgain") {
                        let atlas = SKTextureAtlas(named: "Sprites")
                        let newSprite = SKSpriteNode(texture: atlas.textureNamed("0pikaThunder"))
                        newSprite.size = CGSize(width: self.size.width + 100, height: self.size.height + 100)
                        newSprite.position = pikachu.position
                        self.addChild(newSprite)
                        newSprite.run(action) {
                            newSprite.removeFromParent()
                            self.worldNode.isPaused = false
                            self.physicsWorld.speed = 1
                            self.isAnimationLaunched = false
                            self.pikachu.physicsBody?.applyImpulse(CGVector(dx: self.gameModel.dx * self.gameModel.power,
                                                                            dy: self.gameModel.dy * self.gameModel.power))
                        }
                    }
                }
            }
            else if isAnimationLaunched == false {
                worldNode.isPaused = true
                physicsWorld.speed = 0
                sceneDelegate?.pikachuDidStop(isTeamR: true)
                Pokedex.shared.pokemons.removeAll()
            }
        }
        else {
            if let name = secondNode.name {
                if let pokemon = (pokemons.filter{ $0.name == name }).first {
                    if (Pokedex.shared.pokemons.filter{ $0.name == name }).count == 0 {
                        Pokedex.shared.pokemons.append(pokemon)
                    }
                }
            }
        }
    }
    
    private func setupPikachu() {
                
        pikachu.isHidden = true
        pikachu.size = CGSize(width: 50, height: 70)
        pikachu.zRotation = gameModel.getRadians(from: 30)
        pikachu.position = CGPoint(x: gameModel.pikachuPosition, y: 100)
        
        pikachu.physicsBody = SKPhysicsBody(texture: pikachu.texture!, size: pikachu.size)
        pikachu.physicsBody?.restitution = 0.6
        pikachu.physicsBody?.categoryBitMask = Bits.pikachuCategory
        pikachu.physicsBody?.contactTestBitMask = Bits.teamRCategory | Bits.pokemonCategory    //a mask that defines which categories of bodies cause intersection notifications with this physics body; this tuns "func didBegin(_ contact: SKPhysicsContact)"
        pikachu.physicsBody?.collisionBitMask = Bits.pikachuCollision
        
        worldNode.addChild(pikachu)
    }
    
    private func setupPokeThrower() {
        
        let atlas = SKTextureAtlas(named: "Sprites")
        pokeThrower = SKSpriteNode(texture: atlas.textureNamed("0pokeThrow"))
        pokeThrower.size = CGSize(width: 288, height: 160)
        pokeThrower.position = CGPoint(x: 100, y: pokeThrower.size.height/2)
        
//        if let pokeThrow_start = SKAction(named: "PokeThrow_startAction") {
//            pokeThrower.run(pokeThrow_start)
//        }
        
        worldNode.addChild(pokeThrower)
    }

    private func setupPhysics() {
        
        physicsWorld.gravity = CGVector(dx:0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: gameModel.sceneWidth, height: gameModel.sceneHeight))
        
        physicsWorld.contactDelegate = self
    }

    private func setupCamera() {
        
        cam = SKCameraNode()    //initialize and assign an instance of SKCameraNode to the cam variable.
        
        self.camera = cam       //set the scene's camera to reference cam
        worldNode.addChild(cam)
        
        resetCameraPosition()
    }
    
    func resetCameraPosition() {
        //position the camera on the gamescene.
        cam.position = CGPoint(x: self.frame.midX,
                               y: self.frame.midY)
    }
    
    private func generateObstacles() {
        
        //team R
        for _ in 0 ..< 2 {
            let xPos = gameModel.getRandomInRange(from: 2000, to: gameModel.sceneWidth)
            let obstacle = Obstacle(obstacleType: .TeamR, xPosition: CGFloat(xPos))
            obstacles.append(obstacle)
        }
        
        //team R baloon
        for _ in 0 ..< 2 {
            let xPos = gameModel.getRandomInRange(from: 2500, to: gameModel.sceneWidth)
            let obstacle = Obstacle(obstacleType: .TeamRbaloon, xPosition: CGFloat(xPos))
            obstacles.append(obstacle)
        }

        addObstaclesToScene()
    }
    
    private func addObstaclesToScene() {
        
        obstacles.forEach { (obstacle) in
            worldNode.addChild(obstacle.sprite)
            if let field = obstacle.fieldNode {
                worldNode.addChild(field)
            }
        }
    }
    
    func generatePokemons() {
        pokemons = Pokemon.generatePokemons(gameModel: gameModel)
        
        pokemons.forEach { (poke) in
            worldNode.addChild(poke.sprite)
            worldNode.addChild(poke.fieldNode)
        }
    }
}
