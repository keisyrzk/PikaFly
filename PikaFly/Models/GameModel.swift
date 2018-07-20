//
//  GameModel.swift
//  PikaFly
//
//  Created by Esteban on 20.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import UIKit

class GameModel {
    
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
        power = (nodeFrame.width - 100)
    }
    
    func getDisplacement() {
        
        // dx/dy = arcusTan
        // dx = arcusTan * dy
        let arcusTan = atan(launchAngel)
        dx = arcusTan
        dy = 1
    }
}
