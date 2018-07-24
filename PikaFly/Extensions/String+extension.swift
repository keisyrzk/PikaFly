//
//  String+extension.swift
//  PikaFly
//
//  Created by Esteban on 24.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import UIKit

extension String {
    func capitalizeFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizeFirstLetter()
    }
}
