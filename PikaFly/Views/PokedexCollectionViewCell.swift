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
    
    func config(name: String, image: UIImage?) {
        if let _image = image {
            pokemonImageView.image = _image
        }
        pokemonNameLabel.text = name
    }
    
    override func prepareForReuse() {
        pokemonImageView.image = UIImage()
        pokemonNameLabel.text = ""
    }
}
