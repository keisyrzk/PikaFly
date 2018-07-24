//
//  Bits.swift
//  PikaFly
//
//  Created by Esteban on 24.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import Foundation

struct Bits {
    
    //the bit that represents the body
    static let pikachuCategory: UInt32 = UInt32(2)
    static let teamRCategory: UInt32 = UInt32(4)
    static let pokemonCategory: UInt32 = UInt32(8)
    
    //the bit that represents which bodies collide with it
    //if two object have the same collision mask than thay will collide - if collision masks would be different than such two objects will go through each other
    //these values should be set as a power of "2" so: 1, 2, 4, 8, 16 etc.
    //this is because the contactDelegate uses bitwise AND to compare
    static let pikachuCollision: UInt32 = UInt32(1)
    static let teamRCollision: UInt32 = UInt32(2)
    static let pokemonCollision: UInt32 = UInt32(4)
    
    
}
