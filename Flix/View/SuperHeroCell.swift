//
//  NowPlayingCell.swift
//  Flix
//
//  Created by hor kimleng on 2/13/19.
//  Copyright © 2019 hor kimleng. All rights reserved.
//

import UIKit

class SuperHeroCell: UICollectionViewCell {

    //IBOulets
    @IBOutlet weak var heroImageView: UIImageView!
    
    //Variables
    let baseUrlString = "http://image.tmdb.org/t/p/w185"
    
    func setupCell(superHero: [Movie], index: Int) {
        if let imageUrl = URL(string: baseUrlString + superHero[index].imageString) {
            heroImageView.af_setImage(withURL: imageUrl)
        }
    }
}

