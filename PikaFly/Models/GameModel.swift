//
//  GameModel.swift
//  PikaFly
//
//  Created by Esteban on 20.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import SpriteKit

class GameModel {
    
    var scene: GameScene!
    
    let sceneWidth = 50000
    let sceneHeight = 5000
    let pikachuPosition = 200

    var launchAngel: CGFloat = 0
    var dx: CGFloat = 0
    var dy: CGFloat = 0
    var power: CGFloat = 0
    
    func getRadians(from angle: CGFloat) -> CGFloat {
        return angle * 3.14 / 180
    }
    
    func getAngle(from radians: CGFloat) {
        launchAngel = radians * 180 / 3.14
    }
    
    func getPower(nodeFrame: CGRect) {
        power = (nodeFrame.width - 50)
    }
    
    func getDisplacement() {
        
        // dx/dy = arcusTan
        // dy = dx / arcusTan
        let arcusTan = atan(launchAngel)
        dx = 1
        dy = 1 / arcusTan
    }
    
    func getRandomInRange(from: Int, to: Int) -> CGFloat {
        
        return CGFloat(arc4random_uniform(UInt32(to)) + UInt32(from))
    }
}
