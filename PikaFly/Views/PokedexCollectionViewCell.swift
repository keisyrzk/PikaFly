//
//  PokedexCollectionViewCell.swift
//  PikaFly
//
//  Created by Esteban on 24.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import UIKit

class PokedexCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    func config(pokemon: Pokemon, myPokes: [Pokemon]) {
        
        
        myPokes.forEach { (poke) in
            print("MY_POKE:   \(poke.name)")
        }
        print("now:   \(pokemon.name)")
        
        if let _image = pokemon.image {
            
            let myPokemons = myPokes.filter{ $0.name == pokemon.name }
            
            if myPokemons.count > 0 {
                pokemonImageView.image = _image
            }
            else {
                pokemonImageView.image = _image.withRenderingMode(.alwaysTemplate)
                pokemonImageView.tintColor = UIColor.darkGray
            }
        }
        pokemonNameLabel.text = pokemon.name
    }
    
    override func prepareForReuse() {
        pokemonImageView.image = UIImage()
        pokemonNameLabel.text = ""
    }
}
