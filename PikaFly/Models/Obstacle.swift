//
//  Obstacle.swift
//  PikaFly
//
//  Created by Esteban on 18.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import SpriteKit

enum ObstacleType: Int {
    case Slowpoke
    case Articuno
    
    var spriteName: String {
        let spriteNames = [
            "slowpoke",
            "articuno"]
        
        return spriteNames[rawValue]
    }
    
    static func random() -> ObstacleType {
        return ObstacleType(rawValue: Int(arc4random_uniform(1)))!
    }
}

class Obstacle: CustomStringConvertible, Hashable {
    
    static let pikachuCategory: UInt32 = 0x1 << 0
    static let slowpokeCategory: UInt32 = 0x1 << 1
    
    let obstacleType: ObstacleType
    var sprite: SKSpriteNode
    var fieldNode: SKFieldNode?
    
    var hashValue: Int {
        return obstacleType.hashValue + Int(arc4random_uniform(999999))
    }
    
    var description: String {
        return "type:\(obstacleType)"
    }
    
    static func ==(lhs: Obstacle, rhs: Obstacle) -> Bool {
        return lhs.obstacleType == rhs.obstacleType
    }
    
    
    init(obstacleType: ObstacleType, xPosition: CGFloat) {
        self.obstacleType = obstacleType
        
        switch obstacleType {
            
        case .Slowpoke:
            let newSprite = SKSpriteNode(imageNamed: "slowpokeImage")
            newSprite.size = CGSize(width: 60, height: 48)
            newSprite.position = CGPoint(x: xPosition, y: newSprite.size.height/2)
            
//            newSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: newSprite.size.width,
//                                                                      height: 5),
//                                                  center: CGPoint(x: 0,
//                                                                  y: -newSprite.size.height/2 + 3))
//            newSprite.physicsBody?.isDynamic = false
//            newSprite.physicsBody?.usesPreciseCollisionDetection = true
//            newSprite.physicsBody?.categoryBitMask = Obstacle.slowpokeCategory
            
            let field = SKFieldNode.velocityField(withVector: vector_float3(5,5,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            
            self.fieldNode = field
            self.sprite = newSprite
            
        case .Articuno:
            let atlas = SKTextureAtlas(named: "Articuno")
            let newSprite = SKSpriteNode(texture: atlas.textureNamed("0"))
            newSprite.size = CGSize(width: 128, height: 136)
            newSprite.position = CGPoint(x: xPosition, y: CGFloat(arc4random_uniform(1000) + 300))
            
//            newSprite.physicsBody = SKPhysicsBody(texture: newSprite.texture!, size: newSprite.size)
//            newSprite.physicsBody?.isDynamic = false
//            newSprite.physicsBody?.usesPreciseCollisionDetection = true
//            newSprite.physicsBody?.categoryBitMask = Obstacle.slowpokeCategory
            
            if let action = SKAction(named: "ArticunoAction") {
                newSprite.run(action)
            }
            
            let field = SKFieldNode.velocityField(withVector: vector_float3(10,1,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            
            self.fieldNode = field
            self.sprite = newSprite
        }
        
    }
    
    
}
