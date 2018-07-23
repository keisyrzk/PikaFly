import SpriteKit
import GameplayKit

protocol SceneDelegate {
    func distanceDidChange(distance: String)
    func gameShouldStart()
    func pikachuDidStart()
    func pikachuDidStop()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    enum GameStartState {
        case Started
        case ChooseAngle
        case ChoosePower
        case Launched
    }
    
    let pikachu = SKSpriteNode(imageNamed: "pikachuImage")
    var pokeThrower = SKSpriteNode()
    var obstacles: [Obstacle] = []
    var cam: SKCameraNode!
    
    let sceneWidth = 50000
    let sceneHeight = 5000
    let pikachuPosition = 200
    
    var gameStartedState: GameStartState = .Started
    
    let gameModel = GameModel()
    var sceneDelegate: SceneDelegate? = nil
    
    
    override func didMove(to view: SKView) {
        
        setupCamera()
        setupPikachu()
        
        setupPhysics()
        generateObstacles()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch gameStartedState {
            
        case .Started:
            
            setupPokeThrower()
            
            sceneDelegate?.pikachuDidStart()
            
            let launcher = Launcher.createLaucher(from: pokeThrower.position)
            self.addChild(launcher)
            launcher.run(Launcher.getAngleAction())
            
            gameStartedState = .ChooseAngle
            
        case .ChooseAngle:
            
            if let launcherNode = self.children.last {
                gameModel.getAngle(from: launcherNode.zRotation)
                gameModel.getDisplacement()

                launcherNode.removeAllActions()
                launcherNode.run(Launcher.getPowerAction())
            }
        
            gameStartedState = .ChoosePower
            
        case .ChoosePower:
            
            if let launcherNode = self.children.last {
                
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
        
        let distance = Int(pikachu.position.x) - Int(pikachuPosition)
        let pikachuDidStop = abs(Int32(pikachu.physicsBody!.velocity.dx)) < 5 && abs(Int32(pikachu.physicsBody!.velocity.dy)) < 5
        sceneDelegate?.distanceDidChange(distance: "\(distance > 0 ? distance : 0)m")
        
        if pikachuDidStop && distance > 0 {
            sceneDelegate?.pikachuDidStop()
        }
    }
    
//    func didBegin(_ contact: SKPhysicsContact) {
//        
//        let secondNode = contact.bodyB.node as! SKSpriteNode
//        
//        if (contact.bodyA.categoryBitMask == Obstacle.pikachuCategory) && (contact.bodyB.categoryBitMask == Obstacle.slowpokeCategory) {
//            
//            let contactPoint = contact.contactPoint
//            let contact_y = contactPoint.y
//            let target_y = secondNode.position.y
//            let margin = secondNode.frame.size.height/2 - 25
//
//            pikachu.physicsBody?.velocity = CGVector(dx: 1000, dy: -3000)
//        }
//    }
    
    private func setupPikachu() {
        
        pikachu.isHidden = true
        pikachu.size = CGSize(width: 50, height: 70)
        pikachu.zRotation = gameModel.getRadians(from: 30)
        pikachu.position = CGPoint(x: pikachuPosition, y: 100)
        
        pikachu.physicsBody = SKPhysicsBody(texture: pikachu.texture!, size: pikachu.size)
        pikachu.physicsBody?.restitution = 0.6
        pikachu.physicsBody?.categoryBitMask = Obstacle.pikachuCategory
        pikachu.physicsBody?.contactTestBitMask = Obstacle.pikachuCategory | Obstacle.slowpokeCategory
        
        self.addChild(pikachu)
    }
    
    private func setupPokeThrower() {
        
        let atlas = SKTextureAtlas(named: "Sprites")
        pokeThrower = SKSpriteNode(texture: atlas.textureNamed("0pokeThrow"))
        pokeThrower.size = CGSize(width: 288, height: 160)
        pokeThrower.position = CGPoint(x: 100, y: pokeThrower.size.height/2)
        
        if let pokeThrow_start = SKAction(named: "PokeThrow_startAction") {
            pokeThrower.run(pokeThrow_start)
        }
        
        self.addChild(pokeThrower)
    }

    private func setupPhysics() {
        
        physicsWorld.gravity = CGVector(dx:0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: sceneWidth, height: sceneHeight))
        
        physicsWorld.contactDelegate = self
    }

    private func setupCamera() {
        
        cam = SKCameraNode()    //initialize and assign an instance of SKCameraNode to the cam variable.
        
        self.camera = cam       //set the scene's camera to reference cam
        self.addChild(cam)
        
        resetCameraPosition()
    }
    
    func resetCameraPosition() {
        //position the camera on the gamescene.
        cam.position = CGPoint(x: self.frame.midX,
                               y: self.frame.midY)
    }
    
    private func generateObstacles() {
        
        // slowpoke
        for xPos in stride(from: 600, to: sceneWidth, by: 1500) {
            let obstacle = Obstacle(obstacleType: .Slowpoke, xPosition: CGFloat(xPos))
            obstacles.append(obstacle)
        }
        
        // articuno
        for xPos in stride(from: 200, to: sceneWidth, by: 2500) {
            let obstacle = Obstacle(obstacleType: .Articuno, xPosition: CGFloat(xPos))
            obstacles.append(obstacle)
        }
        
        // charizard
        for xPos in stride(from: 300, to: sceneWidth, by: 4000) {
            let obstacle = Obstacle(obstacleType: .Charizard, xPosition: CGFloat(xPos))
            obstacles.append(obstacle)
        }
        
        addObstaclesToScene()
    }
    
    private func addObstaclesToScene() {
        
        obstacles.forEach { (obstacle) in
            self.addChild(obstacle.sprite)
            if let field = obstacle.fieldNode {
                self.addChild(field)
            }
        }
    }
    
    
    
//    private func setupObstacles() {
//
//        self.children.forEach { (node) in
//
//            if let _node = node as? SKSpriteNode {
//
//                switch _node.name {
//
//                case "slowpoke":
//                    addObstacle(obstacleType: .Slowpoke, node: _node)
//
//                case "articuno":
//                    addObstacle(obstacleType: .Articuno, node: _node)
//
//                default:
//                    break
//                }
//            }
//        }
//    }
//
//
//    private func addObstacle(obstacleType: ObstacleType, node: SKSpriteNode) {
//
//        switch obstacleType {
//
//        case .Slowpoke:
//            let obstacle = Obstacle(obstacleType: .Slowpoke)
//            node.physicsBody = obstacle.sprite.physicsBody
//            node.size = obstacle.sprite.size
//            obstacles.append(obstacle)
//
//        case .Articuno:
//            let obstacle = Obstacle(obstacleType: .Articuno)
//            node.physicsBody = obstacle.sprite.physicsBody
//            node.size = obstacle.sprite.size
//            obstacles.append(obstacle)
//        }
//    }
}
