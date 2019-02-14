//
//  DetailsViewController.swift
//  Flix
//
//  Created by hor kimleng on 2/11/19.
//  Copyright © 2019 hor kimleng. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailsViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //Variables
    let baseUrlString = "http://image.tmdb.org/t/p/w780"
    var details: Movie?
    var movieImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        movieImageView.addGestureRecognizer(tap)
        movieImageView.isUserInteractionEnabled = true
        
        if let imageUrl = URL(string: baseUrlString + (details?.bannerString)!) {
            bannerImageView.af_setImage(withURL: imageUrl)
        }
        
        movieTitleLabel.text = details?.title
        descriptionTextView.text = details?.description
        movieImageView.image = movieImage
        dateLabel.text = details?.releaseDate
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "webVC") as! WebViewController
        if let id = details?.id {
            webVC.id = id
        }
        
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}
