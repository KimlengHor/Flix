//
//  MoviesCell.swift
//  Flix
//
//  Created by hor kimleng on 2/1/19.
//  Copyright © 2019 hor kimleng. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesCell: UITableViewCell {

    //IBOutlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    
    //Variables
    let baseUrlString = "http://image.tmdb.org/t/p/w185"

    func setUpCell(movies: [Movie], index: Int) {
        if let imageUrl = URL(string: baseUrlString + movies[index].imageString) {
            movieImageView.af_setImage(withURL: imageUrl)
        }
        movieTitle.text = movies[index].title
        movieDescription.text = movies[index].description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
