import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let pikachu = SKSpriteNode(imageNamed: "pikachuImage")
    var obstacles: [Obstacle] = []
    var cam: SKCameraNode!
    
    
    override func didMove(to view: SKView) {
        
        setupCamera()
        setupLauncher()
        setupPikachu()
        
        setupPhysics()
        setupObstacles()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        physicsWorld.gravity = CGVector(dx:0 , dy: -9.8)
    }
    
    // a way to add new sprites in a loop
    override func didSimulatePhysics() {

        if pikachu.position.x >= self.frame.width/2 {
            cam.position = CGPoint(x: pikachu.position.x, y: self.frame.height/2)
        }
            
       // print("DISTANCE:   \(roundf(Float(pikachu.position.x) - Float(50)))m")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let secondNode = contact.bodyB.node as! SKSpriteNode
        
        if (contact.bodyA.categoryBitMask == Obstacle.pikachuCategory) && (contact.bodyB.categoryBitMask == Obstacle.slowpokeCategory) {
            
            let contactPoint = contact.contactPoint
            let contact_y = contactPoint.y
            let target_y = secondNode.position.y
            let margin = secondNode.frame.size.height/2 - 25
                        
            pikachu.physicsBody?.velocity = CGVector(dx: 1000, dy: -3000)
        }
    }
    
    private func setupPikachu() {
        
        pikachu.size = CGSize(width: 50, height: 70)
        pikachu.zRotation = getRadians(from: 30)
        pikachu.position = CGPoint(x: 50, y: 200)
        
        pikachu.physicsBody = SKPhysicsBody(texture: pikachu.texture!, size: pikachu.size)
        pikachu.physicsBody?.restitution = 0.6
        pikachu.physicsBody?.categoryBitMask = Obstacle.pikachuCategory
        pikachu.physicsBody?.contactTestBitMask = Obstacle.pikachuCategory | Obstacle.slowpokeCategory
        
        self.addChild(pikachu)
    }
    
    private func setupLauncher() {
        
        let rectangle = SKSpriteNode(color: .blue, size: CGSize(width: size.width, height: 20))
        rectangle.physicsBody = SKPhysicsBody(rectangleOf: rectangle.size)
        rectangle.zRotation = getRadians(from: 160)
        rectangle.physicsBody?.isDynamic = false
        rectangle.physicsBody?.friction = 0.0
        rectangle.position = CGPoint(x: 50, y: 50)
        self.addChild(rectangle)
    }


    private func setupPhysics() {
        
        physicsWorld.gravity = CGVector(dx:0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: 100000, height: 5000))
        
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

    
    private func getRadians(from angle: CGFloat) -> CGFloat {
        return angle * 3.14 / 180
    }
    
    private func setupObstacles() {
        
        self.children.forEach { (node) in
            
            if let _node = node as? SKSpriteNode {
                
                switch _node.name {
                    
                case "slowpoke":
                    addObstacle(obstacleType: .Slowpoke, node: _node)
                    
                case "articuno":
                    addObstacle(obstacleType: .Articuno, node: _node)

                default:
                    break
                }
            }
        }
    }
    
    private func addObstacle(obstacleType: ObstacleType, node: SKSpriteNode) {
        
        switch obstacleType {
            
        case .Slowpoke:
            let obstacle = Obstacle(obstacleType: .Slowpoke)
            node.physicsBody = obstacle.sprite.physicsBody
            node.size = obstacle.sprite.size
            obstacles.append(obstacle)

        case .Articuno:
            let obstacle = Obstacle(obstacleType: .Articuno)
            node.physicsBody = obstacle.sprite.physicsBody
            node.size = obstacle.sprite.size
            obstacles.append(obstacle)
        }
        
        
    }
}
