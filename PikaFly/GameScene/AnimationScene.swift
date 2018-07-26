//
//  AnimationScene.swift
//  PikaFly
//
//  Created by Esteban on 26.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import SpriteKit

protocol AnimationDelegate {
    func animationDidEnd()
}

class AnimationScene: SKScene {
    
    var animationDelegate: AnimationDelegate? = nil
    
    override func didMove(to view: SKView) {
        
        if let action = SKAction(named: "TeamRBlastOffAgain") {
            let atlas = SKTextureAtlas(named: "Sprites")
            let newSprite = SKSpriteNode(texture: atlas.textureNamed("0pikaThunder"))
            newSprite.size = CGSize(width: self.size.width,
                                    height: self.size.height)
            
            newSprite.position = CGPoint(x: self.frame.midX,
                                         y: self.frame.midY)
            
            self.addChild(newSprite)
            newSprite.run(action) {
                self.animationDelegate?.animationDidEnd()
            }
        }
    }
}
