//
//  Pokemon.swift
//  PikaFly
//
//  Created by Esteban on 23.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import SpriteKit

class Pokemon: CustomStringConvertible, Hashable {
    
    var hashValue: Int {
        return type.hashValue + Int(arc4random_uniform(999999)) + name.hashValue
    }
    
    var description: String {
        return "type:\(type)"
    }
    
    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.type == rhs.type
    }
    
    static let pokeDict: [String:PokemonType] = ["abra":.Psychic,
                                          "kadabra":.Psychic,
                                          "alakazam":.Psychic,
                                          "arbok":.Toxic,
                                          "ekans":.Toxic,
                                          "nidoking":.Toxic,
                                          "nidoranFemale":.Toxic,
                                          "nidoranMale":.Toxic,
                                          "nidorino":.Toxic,
                                          "blastoise":.Water,
                                          "wartortle":.Water,
                                          "totodile":.Water,
                                          "squirtle":.Water,
                                          "slowbro":.Water,
                                          "psyduck":.Water,
                                          "bulbasaur":.Grass,
                                          "chikorita":.Grass,
                                          "venusaur":.Grass,
                                          "ivysaur":.Grass,
                                          "metapod":.Grass,
                                          "charmeleon":.Fire,
                                          "charmander":.Fire,
                                          "cindaquil":.Fire,
                                          "charizard":.Fire,
                                          "caterpie":.Bug,
                                          "diglett":.Ground,
                                          "dugtrio":.Ground,
                                          "sandslash":.Ground,
                                          "dragonair":.Dragon,
                                          "dragonite":.Dragon,
                                          "dratini":.Dragon,
                                          "gastly":.Ghost,
                                          "gengar":.Ghost,
                                          "hunter":.Ghost,
                                          "jolteon":.Electric,
                                          "hitmanchan":.Fighting,
                                          "hitmonlee":.Fighting,
                                          "phanphy":.Normal,
                                          "snorlax":.Normal,
                                          "spearow":.Normal,
                                          "nidoqueen":.Ice,
                                          "nidorina":.Ice,
                                          "butterfree":.Flying,
                                          "fearow":.Flying,
                                          "golbat":.Flying,
                                          "koffing":.Flying,
                                          "magnemite":.Flying,
                                          "magneton":.Flying,
                                          "mewtwo":.Flying,
                                          "moltres":.Flying,
                                          "pidgeot":.Flying,
                                          "pidgeotto":.Flying,
                                          "pidgey":.Flying,
                                          "weezing":.Flying,
                                          "zapdos":.Flying,
                                          "zubat":.Flying,
                                          "articuno":.Flying
    ]
    
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
    
    private let minWidth: UInt32 = 50
    private let maxWidth: UInt32 = 80
    
    private let gameModel = GameModel()
    
    var name: String
    var type: PokemonType
    var image: UIImage?
    
    var sprite: SKSpriteNode!
    var fieldNode: SKFieldNode!
    
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
    
    private func createSprite(type: PokemonType) {
        
        let atlas = SKTextureAtlas(named: "Sprites")
        let newSprite = SKSpriteNode(texture: atlas.textureNamed("0\(self.name)"))
        setSize(for: newSprite)

        if self.name == "articuno" || self.name == "charizard" {
            if let action = SKAction(named: "\(self.name)".capitalizeFirstLetter() + "Action") {
                newSprite.run(action)
            }
        }
        
        switch type {
            
        case .Psychic:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(-2,0,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Toxic:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth - 5000),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(-2,0,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Water:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth - 10000),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(2,10,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Grass:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth - 15000),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(2,-3,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Flying:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth - 20000),
                                         y: gameModel.getRandomInRange(from: Int(newSprite.size.height/2) + 100, to: 2000))
            let field = SKFieldNode.velocityField(withVector: vector_float3(8,1,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Fire:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth - 25000),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(-2,0,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Bug:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth - 30000),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(1,-2,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Ground:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth - 35000),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(0,-2,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Dragon:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(1,8,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Ghost:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth - 40000),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(-4,-2,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Fighting:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth - 30000),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(5,-3,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Electric:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth - 25000),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(-2,0,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Ice:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth - 20000),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(5,-5,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
            
        case .Normal:
            newSprite.position = CGPoint(x: gameModel.getRandomInRange(from: 500, to: gameModel.sceneWidth - 15000),
                                         y: newSprite.size.height/2)
            let field = SKFieldNode.velocityField(withVector: vector_float3(2,2,0))
            field.position = newSprite.position
            field.region = SKRegion(size: newSprite.size)
            self.fieldNode = field
        }
        
        self.sprite = newSprite
    }
    
    static func generatePokemons(gameModel: GameModel) -> [Pokemon] {
        
        var pokes: [Pokemon] = []
        let amount = Int(gameModel.getRandomInRange(from: Int(pokeDict.count/2), to: pokeDict.count - 1))
        let pokeAmount = Int(gameModel.getRandomInRange(from: 2, to: 10))
        
        for _ in 0 ..< amount {
            let pokemonIndex = Int(gameModel.getRandomInRange(from: 0, to: pokeDict.count - 1))
            let keys = Array(pokeDict.keys)
            
            for _ in 0 ..< pokeAmount {
                let newPokemon = Pokemon(name: keys[pokemonIndex], type: pokeDict[keys[pokemonIndex]]!)
                
                //check if there is a free space to place new pokemon in range
                //  xPos - 100      pokemon     xPos + 100
                //       | ---------- () ----------- |
                let filtered = pokes.filter{ $0.sprite.position.x > newPokemon.sprite.position.x - 100 && $0.sprite.position.x < newPokemon.sprite.position.x + 100 }
                if filtered.count == 0 {
                    pokes.append(newPokemon)
                }
            }
        }

        return pokes
    }
}
