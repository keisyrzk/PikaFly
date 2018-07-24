//
//  Obstacle.swift
//  PikaFly
//
//  Created by Esteban on 18.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import SpriteKit

enum ObstacleType: Int {
    case TeamR
    case TeamRbaloon
    
    var spriteName: String {
        let spriteNames = [
            "teamR",
            "teamRbaloon"]
        
        return spriteNames[rawValue]
    }
    
    static func random() -> ObstacleType {
        return ObstacleType(rawValue: Int(arc4random_uniform(1)))!
    }
}

class Obstacle: CustomStringConvertible, Hashable {
    
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
            
        case .TeamR:
            let newSprite = SKSpriteNode(imageNamed: "teamR")
            newSprite.size = CGSize(width: 50, height: 98)
            newSprite.position = CGPoint(x: xPosition, y: newSprite.size.height/2)
            
            newSprite.physicsBody = SKPhysicsBody(texture: newSprite.texture!, size: newSprite.size)
            newSprite.physicsBody?.isDynamic = false
            newSprite.physicsBody?.usesPreciseCollisionDetection = true
            newSprite.physicsBody?.categoryBitMask = Bits.teamRCategory
            
            self.sprite = newSprite
            
        case .TeamRbaloon:
            let newSprite = SKSpriteNode(imageNamed: "teamRbaloon")
            newSprite.size = CGSize(width: 132, height: 192)
            newSprite.position = CGPoint(x: xPosition, y: CGFloat(arc4random_uniform(2000) + 400))
            
            newSprite.physicsBody = SKPhysicsBody(texture: newSprite.texture!, size: newSprite.size)
            newSprite.physicsBody?.isDynamic = false
            newSprite.physicsBody?.usesPreciseCollisionDetection = true
            newSprite.physicsBody?.categoryBitMask = Bits.teamRCategory
            
            self.sprite = newSprite

        }
    }
}
