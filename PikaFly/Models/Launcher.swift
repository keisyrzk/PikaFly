//
//  Launcher.swift
//  PikaFly
//
//  Created by Esteban on 20.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import SpriteKit

class Launcher {
    
    static func createAnglePicker(from position: CGPoint) -> SKSpriteNode {
        
        let newSprite = SKSpriteNode(imageNamed: "arrow")
        newSprite.size = CGSize(width: 96, height: 48)
        newSprite.position = position
        
        let action = SKAction(named: "AngleAction")!
        newSprite.run(SKAction.repeatForever(action))
        return newSprite
    }
    
    static func createPowerPicker(from position: CGPoint) -> SKSpriteNode {
        
        let newSprite = SKSpriteNode(imageNamed: "arrow")
        newSprite.size = CGSize(width: 96, height: 48)
        newSprite.position = CGPoint(x: position.x + 50, y: position.y)
        
        let action = SKAction(named: "AngleAction")!
        newSprite.run(SKAction.repeatForever(action))
        return newSprite
    }
}
