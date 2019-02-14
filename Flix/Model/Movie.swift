//
//  Movie.swift
//  Flix
//
//  Created by hor kimleng on 2/1/19.
//  Copyright © 2019 hor kimleng. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    var imageString: String
    var title: String
    var description: String
    var releaseDate: String
    var bannerString: String
    var id: Double
    
    init(imageString: String, title: String, description: String, releaseDate: String, bannerString: String, id: Double) {
        self.imageString = imageString
        self.title = title
        self.description = description
        self.releaseDate = releaseDate
        self.bannerString = bannerString
        self.id = id
    }
    
    
}
