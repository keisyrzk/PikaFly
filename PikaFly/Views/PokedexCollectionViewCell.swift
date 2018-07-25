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
        
        
        if let _image = pokemon.image {
            if myPokes.contains(pokemon) {
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
