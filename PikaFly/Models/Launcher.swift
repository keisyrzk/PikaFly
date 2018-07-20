//
//  Launcher.swift
//  PikaFly
//
//  Created by Esteban on 20.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import SpriteKit

class Launcher {
    
    static func createLaucher(from position: CGPoint) -> SKSpriteNode {
        let newSprite = SKSpriteNode(imageNamed: "arrow")
        newSprite.size = CGSize(width: 96, height: 48)
        newSprite.position = CGPoint(x: position.x + 50, y: position.y)
        
        return newSprite
    }
    
    static func getAngleAction() -> SKAction {
        
        let action = SKAction(named: "AngleAction")!
        return SKAction.repeatForever(action)
    }
    
    static func getPowerAction() -> SKAction {
        
        let action = SKAction(named: "PowerAction")!
        return SKAction.repeatForever(action)
    }
}
