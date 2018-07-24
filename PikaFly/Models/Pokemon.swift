//
//  Pokemon.swift
//  PikaFly
//
//  Created by Esteban on 23.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import SpriteKit

class Pokemon {
    
    enum PokemonType {
        case Psychic
        case Toxic
        case Water
        case Grass
        case Flying
        case Fire
        case Bug
        case Ground
        case Dragon
        case Ghost
        case Fighting
        case Electric
        case Ice
        case Normal
    }
    
    private let minWidth: UInt32 = 30
    private let maxWidth: UInt32 = 200
    
    private let gameModel = GameModel()
    
    var name: String
    var type: PokemonType
    var image: UIImage?
    
    var sprite: SKSpriteNode!
    var fieldNode: SKFieldNode?
    
    init(name: String, type: PokemonType) {
        self.name = name
        self.type = type
        if let _image = UIImage(named: name) {
            self.image = _image
        }
        
        createSprite(type: type)
    }
    
    private func setSize(for sprite: SKSpriteNode) {
        
        let width = sprite.size.width
        let height = sprite.size.height
        let aspectRatio = height/width
        
        let newWidth = arc4random_uniform(maxWidth) + minWidth
        let newHeight = aspectRatio * CGFloat(newWidth)
        
        sprite.size = CGSize(width: CGFloat(newWidth),
                             height: newHeight)
    }
    
    private func getRandomInRange(from: Int, to: Int) -> CGFloat {
        
        return CGFloat(arc4random_uniform(UInt32(from)) + UInt32(to))
    }
    
    private func createSprite(type: PokemonType) {
        
        let atlas = SKTextureAtlas(named: "Sprites")
        let newSprite = SKSpriteNode(texture: atlas.textureNamed("0\(self.name)"))
        setSize(for: newSprite)
        if let action = SKAction(named: "\(self.name)".capitalizeFirstLetter() + "Action") {
            newSprite.run(action)
        }
        
        
        switch type {
            
        case .Psychic:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.radialGravityField()
            field.strength = 3
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Toxic:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.dragField()
            field.strength = 3
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Water:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(5,5,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Grass:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(2,-3,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Flying:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(8,1,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Fire:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.dragField()
            field.strength = 5
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Bug:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(1,-2,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Ground:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.linearGravityField(withVector: vector_float3(0,-9.8,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Dragon:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(1,5,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Ghost:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.vortexField()
            field.direction = vector_float3(-5, 0, 0)
            field.strength = 5
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Fighting:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(5,-3,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Electric:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.dragField()
            field.strength = 3
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Ice:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(5,-5,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Normal:
            newSprite.position = CGPoint(x: getRandomInRange(from: gameModel.sceneWidth, to: 500),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(2,2,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
        }
        
        self.sprite = newSprite
    }
    
    static func generatePokemons(gameModel: GameModel) -> [Pokemon] {
        
        var pokemons: [Pokemon] = []
        
        pokemons.append(Pokemon(name: "abra", type: .Psychic))
        pokemons.append(Pokemon(name: "kadabra", type: .Psychic))
        pokemons.append(Pokemon(name: "alakazam", type: .Psychic))
        pokemons.append(Pokemon(name: "arbok", type: .Toxic))
        pokemons.append(Pokemon(name: "blastoise", type: .Water))
        pokemons.append(Pokemon(name: "bulbasaur", type: .Grass))
        pokemons.append(Pokemon(name: "butterfree", type: .Flying))
        pokemons.append(Pokemon(name: "charmeleon", type: .Fire))
        pokemons.append(Pokemon(name: "caterpie", type: .Bug))
        pokemons.append(Pokemon(name: "charmander", type: .Fire))
        pokemons.append(Pokemon(name: "chikorita", type: .Grass))
        pokemons.append(Pokemon(name: "cindaquil", type: .Fire))
        pokemons.append(Pokemon(name: "diglett", type: .Ground))
        pokemons.append(Pokemon(name: "dragonair", type: .Dragon))
        pokemons.append(Pokemon(name: "dragonite", type: .Dragon))
        pokemons.append(Pokemon(name: "dratini", type: .Dragon))
        pokemons.append(Pokemon(name: "dugtrio", type: .Ground))
        pokemons.append(Pokemon(name: "ekans", type: .Toxic))
        pokemons.append(Pokemon(name: "fearow", type: .Flying))
        pokemons.append(Pokemon(name: "gastly", type: .Ghost))
        pokemons.append(Pokemon(name: "gengar", type: .Ghost))
        pokemons.append(Pokemon(name: "golbat", type: .Flying))
        pokemons.append(Pokemon(name: "hitmanchan", type: .Fighting))
        pokemons.append(Pokemon(name: "hitmonlee", type: .Fighting))
        pokemons.append(Pokemon(name: "hunter", type: .Ghost))
        pokemons.append(Pokemon(name: "ivysaur", type: .Grass))
        pokemons.append(Pokemon(name: "jolteon", type: .Electric))
        pokemons.append(Pokemon(name: "koffing", type: .Flying))
        pokemons.append(Pokemon(name: "magnemite", type: .Flying))
        pokemons.append(Pokemon(name: "magneton", type: .Flying))
        pokemons.append(Pokemon(name: "metapod", type: .Grass))
        pokemons.append(Pokemon(name: "mewtwo", type: .Flying))
        pokemons.append(Pokemon(name: "moltres", type: .Flying))
        pokemons.append(Pokemon(name: "nidoking", type: .Toxic))
        pokemons.append(Pokemon(name: "nidoqueen", type: .Ice))
        pokemons.append(Pokemon(name: "nidoranFemale", type: .Toxic))
        pokemons.append(Pokemon(name: "nidoranMale", type: .Toxic))
        pokemons.append(Pokemon(name: "nidorina", type: .Ice))
        pokemons.append(Pokemon(name: "nidorino", type: .Toxic))
        pokemons.append(Pokemon(name: "phanphy", type: .Normal))
        pokemons.append(Pokemon(name: "pidgeot", type: .Flying))
        pokemons.append(Pokemon(name: "pidgeotto", type: .Flying))
        pokemons.append(Pokemon(name: "pidgey", type: .Flying))
        pokemons.append(Pokemon(name: "psyduck", type: .Water))
        pokemons.append(Pokemon(name: "sandslash", type: .Ground))
        pokemons.append(Pokemon(name: "slowbro", type: .Water))
        pokemons.append(Pokemon(name: "snorlax", type: .Normal))
        pokemons.append(Pokemon(name: "spearow", type: .Normal))
        pokemons.append(Pokemon(name: "squirtle", type: .Water))
        pokemons.append(Pokemon(name: "totodile", type: .Water))
        pokemons.append(Pokemon(name: "venusaur", type: .Grass))
        pokemons.append(Pokemon(name: "wartortle", type: .Water))
        pokemons.append(Pokemon(name: "weezing", type: .Flying))
        pokemons.append(Pokemon(name: "zapdos", type: .Flying))
        pokemons.append(Pokemon(name: "zubat", type: .Flying))
        pokemons.append(Pokemon(name: "articuno", type: .Flying))
        pokemons.append(Pokemon(name: "charizard", type: .Fire))
        
        return pokemons
    }
}
