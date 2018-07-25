//
//  Pokedex.swift
//  PikaFly
//
//  Created by Esteban on 24.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import SpriteKit

class Pokedex {
    
    static let shared = Pokedex()
    
    var allPokes: [Pokemon] = []
    var pokemons: [Pokemon] = []
    
    init() {
        self.allPokes = getAll()
    }
    
    private func getAll() -> [Pokemon] {
        
        var allPokes: [Pokemon] = []
        let keys = Array(Pokemon.pokeDict.keys)
        
        keys.forEach { (key) in
            let poke = Pokemon(name: key, type: Pokemon.pokeDict[key]!)
            allPokes.append(poke)
        }
        
        return allPokes
    }
}
