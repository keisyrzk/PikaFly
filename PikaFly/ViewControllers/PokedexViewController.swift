//
//  PokedexViewController.swift
//  PikaFly
//
//  Created by Esteban on 24.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {

    @IBOutlet weak var pokedexCollection: PokedexCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokedexCollection.inputDataSource = Array(Pokedex.shared.pokemons)
    }

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
