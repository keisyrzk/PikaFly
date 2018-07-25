//
//  PokedexCollectionView.swift
//  PikaFly
//
//  Created by Esteban on 24.07.2018.
//  Copyright © 2018 Selfcode. All rights reserved.
//

import UIKit

class PokedexCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var allPokes: [Pokemon] = Pokedex.shared.allPokes
    var inputDataSource: [Pokemon] = []
    
    override func awakeFromNib() {
        delegate = self
        dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPokes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PokedexCollectionViewCell
        cell.config(pokemon: allPokes[indexPath.row], myPokes: inputDataSource)
        return cell
    }
}
