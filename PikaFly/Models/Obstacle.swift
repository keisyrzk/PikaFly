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
    case Slowpoke
    case Articuno
    case Charizard
    
    var spriteName: String {
        let spriteNames = [
            "teamR",
            "teamRbaloon",
            "slowpoke",
            "articuno",
            "charizard"]
        
        return spriteNames[rawValue]
    }
    
    static func random() -> ObstacleType {
        return ObstacleType(rawValue: Int(arc4random_uniform(1)))!
    }
}

class Obstacle: CustomStringConvertible, Hashable {
    
    //the bit that represents the body
    static let pikachuCategory: UInt32 = UInt32(2)
    static let teamRCategory: UInt32 = UInt32(4)
    
    //the bit that represents which bodies collide with it
    //if two object have the same collision mask than thay will collide - if collision masks would be different than such two objects will go through each other
    //these values should be set as a power of "2" so: 1, 2, 4, 8, 16 etc.
    //this is because the contactDelegate uses bitwise AND to compare
    static let pikachuCollision: UInt32 = UInt32(1)
    static let teamRCollision: UInt32 = UInt32(2)
    
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
            newSprite.physicsBody?.categoryBitMask = Obstacle.teamRCategory
            
            self.sprite = newSprite
            
        case .TeamRbaloon:
            let newSprite = SKSpriteNode(imageNamed: "teamRbaloon")
            newSprite.size = CGSize(width: 132, height: 192)
            newSprite.position = CGPoint(x: xPosition, y: CGFloat(arc4random_uniform(2000) + 400))
            
            newSprite.physicsBody = SKPhysicsBody(texture: newSprite.texture!, size: newSprite.size)
            newSprite.physicsBody?.isDynamic = false
            newSprite.physicsBody?.usesPreciseCollisionDetection = true
            newSprite.physicsBody?.categoryBitMask = Obstacle.teamRCategory
            
            self.sprite = newSprite
            
        case .Slowpoke:
            let newSprite = SKSpriteNode(imageNamed: "slowpokeImage")
            newSprite.size = CGSize(width: 60, height: 48)
            newSprite.position = CGPoint(x: xPosition, y: newSprite.size.height/2)
            
            let field = SKFieldNode.velocityField(withVector: vector_float3(5,5,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            
            self.fieldNode = field
            self.sprite = newSprite
            
        case .Articuno:
            let atlas = SKTextureAtlas(named: "Sprites")
            let newSprite = SKSpriteNode(texture: atlas.textureNamed("0"))
            newSprite.size = CGSize(width: 128, height: 136)
            newSprite.position = CGPoint(x: xPosition, y: CGFloat(arc4random_uniform(1000) + 300))
            
            if let action = SKAction(named: "ArticunoAction") {
                newSprite.run(action)
            }
            
            let field = SKFieldNode.velocityField(withVector: vector_float3(10,1,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            
            self.fieldNode = field
            self.sprite = newSprite
            
        case .Charizard:
            let atlas = SKTextureAtlas(named: "Sprites")
            let newSprite = SKSpriteNode(texture: atlas.textureNamed("0charizard"))
            newSprite.size = CGSize(width: 190, height: 104)
            newSprite.position = CGPoint(x: xPosition, y: newSprite.size.height/2)
            
            if let action = SKAction(named: "CharizardAction") {
                newSprite.run(action)
            }
            
            let field = SKFieldNode.velocityField(withVector: vector_float3(20,2,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            
            self.fieldNode = field
            self.sprite = newSprite
        }
    }
}
