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
    
    var spriteName: String {
        let spriteNames = [
            "slowpoke"]
        
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
    
    var hashValue: Int {
        return obstacleType.hashValue + Int(arc4random_uniform(999999))
    }
    
    var description: String {
        return "type:\(obstacleType)"
    }
    
    static func ==(lhs: Obstacle, rhs: Obstacle) -> Bool {
        return lhs.obstacleType == rhs.obstacleType
    }
    
    
    init(obstacleType: ObstacleType) {
        self.obstacleType = obstacleType
        
        switch obstacleType {
            
        case .Slowpoke:
            let newSprite = SKSpriteNode(imageNamed: "slowpokeImage")
            newSprite.size = CGSize(width: 60, height: 48)
            newSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: newSprite.size.width,
                                                                      height: 5),
                                                  center: CGPoint(x: 0,
                                                                  y: -newSprite.size.height/2 + 1))
                        
            newSprite.physicsBody?.isDynamic = false
            newSprite.physicsBody?.usesPreciseCollisionDetection = true
            newSprite.physicsBody?.categoryBitMask = Obstacle.slowpokeCategory
            
            self.sprite = newSprite
        }
    }
    
    
}
