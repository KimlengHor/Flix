//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by hor kimleng on 2/13/19.
//  Copyright © 2019 hor kimleng. All rights reserved.
//

import UIKit

private let reuseIdentifier = "superHeroCell"

class SuperHeroViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    //Variables
    var data: [[String: Any]] = []
    var superHeros = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.navigationController?.navigationBar.topItem?.title = "Superhero"
        
        setUpCollectionViewLayout()
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        DataDownload.sharedInstance.downloadMovies(url: url) { (results) in
            self.data = results
            for index in 0..<self.data.count {
                let result = self.data[index]
                let imageString = result["poster_path"] as! String
                let superHeroTitle = result["title"] as! String
                let superHeroDescription = result["overview"] as! String
                let releaseDate = result["release_date"] as! String
                let bannerString = result["backdrop_path"] as! String
                let id = result["id"] as! Double
                self.superHeros.append(Movie(imageString: imageString, title: superHeroTitle, description: superHeroDescription, releaseDate: releaseDate, bannerString: bannerString, id: id))
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func setUpCollectionViewLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        let width = (view.frame.width - layout.minimumInteritemSpacing) / 2
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as! DetailsViewController
        let cell = sender as! SuperHeroCell
        let indexPath = collectionView.indexPath(for: cell)
        detailsVC.details = superHeros[(indexPath?.row)!]
        detailsVC.movieImage = cell.heroImageView.image
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return superHeros.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SuperHeroCell
    
        // Configure the cell
        cell.setupCell(superHero: superHeros, index: indexPath.row)
    
        return cell
    }

}
