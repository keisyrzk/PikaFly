import SpriteKit
import GameplayKit

protocol SceneDelegate {
    func distanceDidChange(distance: String)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    enum GameStartState {
        case Started
        case ChooseAngle
        case ChoosePower
        case Launched
    }
    
    let pikachu = SKSpriteNode(imageNamed: "pikachuImage")
    var obstacles: [Obstacle] = []
    var cam: SKCameraNode!
    
    let sceneWidth = 50000
    let sceneHeight = 5000
    
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
            
            let anglePicker = Launcher.createAnglePicker(from: pikachu.position)
            self.addChild(anglePicker)
            
            gameStartedState = .ChooseAngle
            
        case .ChooseAngle:
            
            if let angleNode = self.children.last {
                gameModel.getAngle(from: angleNode.zRotation)
                gameModel.getDisplacement()
                angleNode.removeFromParent()
            }
            
            let powerPicker = Launcher.createPowerPicker(from: pikachu.position)
            self.addChild(powerPicker)
        
            gameStartedState = .ChoosePower
            
        case .ChoosePower:
            
            if let powerNode = self.children.last {
                
                
                
                powerNode.removeFromParent()
            }
            
            gameStartedState = .Launched
            physicsWorld.gravity = CGVector(dx:0 , dy: -9.8)
            pikachu.physicsBody?.applyImpulse(CGVector(dx: gameModel.dx * gameModel.power,
                                                       dy: gameModel.dy * gameModel.power))
            
        default:
            break
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
        
        let distance = "\(Int(pikachu.position.x) - Int(49))m"
        sceneDelegate?.distanceDidChange(distance: distance)
        
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
        
        pikachu.size = CGSize(width: 50, height: 70)
        pikachu.zRotation = gameModel.getRadians(from: 30)
        pikachu.position = CGPoint(x: 50, y: 100)
        
        pikachu.physicsBody = SKPhysicsBody(texture: pikachu.texture!, size: pikachu.size)
        pikachu.physicsBody?.restitution = 0.6
        pikachu.physicsBody?.categoryBitMask = Obstacle.pikachuCategory
        pikachu.physicsBody?.contactTestBitMask = Obstacle.pikachuCategory | Obstacle.slowpokeCategory
        
        self.addChild(pikachu)
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
        for xPos in stride(from: 300, to: sceneWidth * 8 / 100, by: 500) {
            let obstacle = Obstacle(obstacleType: .Slowpoke, xPosition: CGFloat(xPos))
            obstacles.append(obstacle)
        }
        
        // articuno
        for xPos in stride(from: 200, to: sceneWidth * 8 / 100, by: 500) {
            let obstacle = Obstacle(obstacleType: .Articuno, xPosition: CGFloat(xPos))
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
