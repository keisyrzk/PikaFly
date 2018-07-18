import SpriteKit

class GameScene: SKScene {
    
    var cam:SKCameraNode!
    
    override func didMove(to view: SKView) {
        
        setupCamera()
        setupLauncher()
        setupPikachu()
        
        setupPhysics()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        physicsWorld.gravity = CGVector(dx:0 , dy: -9.8)
    }
    
    // a way to add new sprites in a loop
    override func didSimulatePhysics() {
        if let newX = self.children.last?.position.x {

            if newX >= self.frame.width/2 {
                cam.position = CGPoint(x: newX, y: self.frame.height/2)
            }
        }
    }
    
    private func setupPikachu() {
        
        let pikachu = SKSpriteNode(imageNamed: "pikachuImage")
        pikachu.size = CGSize(width: 50, height: 70)
        pikachu.zRotation = getRadians(from: 30)
        pikachu.position = CGPoint(x: 50, y: 200)
        
        pikachu.physicsBody = SKPhysicsBody(texture: pikachu.texture!, size: pikachu.size)
        pikachu.physicsBody?.restitution = 0.8
        
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
//        physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
         physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: 3000, height: 320))
    }

    private func setupCamera() {
        
        cam = SKCameraNode()    //initialize and assign an instance of SKCameraNode to the cam variable.
        
        self.camera = cam       //set the scene's camera to reference cam
        self.addChild(cam)
        
        //position the camera on the gamescene.
        cam.position = CGPoint(x: self.frame.midX,
                               y: self.frame.midY)
    }

    
    private func getRadians(from angle: CGFloat) -> CGFloat {
        return angle * 3.14 / 180
    }

}
