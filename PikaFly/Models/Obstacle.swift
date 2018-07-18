//
//  Obstacle.swift
//  PikaFly
//
//  Created by Esteban on 18.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import SpriteKit

enum ObstacleType: Int {
    case Bed
    
    var spriteName: String {
        let spriteNames = [
            "bed"]
        
        return spriteNames[rawValue]
    }
    
    static func random() -> ObstacleType {
        return ObstacleType(rawValue: Int(arc4random_uniform(1)))!
    }
}

class Obstacle: CustomStringConvertible, Hashable {
    
    static let pikachuCategory: UInt32 = 0x1 << 0
    static let bedCategory: UInt32 = 0x1 << 1
    
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
            
        case .Bed:
            let newSprite = SKSpriteNode(imageNamed: "bed")
            newSprite.size = CGSize(width: 50, height: 50)
            newSprite.physicsBody = SKPhysicsBody(rectangleOf: newSprite.size)
            newSprite.position = CGPoint(x: 200, y: 0)
            
            newSprite.physicsBody?.isDynamic = false
            newSprite.physicsBody?.usesPreciseCollisionDetection = true
            newSprite.physicsBody?.categoryBitMask = Obstacle.bedCategory
            
            self.sprite = newSprite
            
        }
    }
    
    
}
