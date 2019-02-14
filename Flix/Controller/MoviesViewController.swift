//
//  MoviesViewController.swift
//  Flix
//
//  Created by hor kimleng on 2/1/19.
//  Copyright © 2019 hor kimleng. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //IBOulets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var data: [[String: Any]] = []
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.topItem?.title = "Movies"

        tableView.delegate = self
        tableView.dataSource = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        DataDownload.sharedInstance.downloadMovies(url: url) { (results) in
            self.data = results
            for index in 0..<self.data.count {
                let result = self.data[index]
                let imageString = result["poster_path"] as! String
                let movieTitle = result["title"] as! String
                let movieDescription = result["overview"] as! String
                let releaseDate = result["release_date"] as! String
                let bannerString = result["backdrop_path"] as! String
                let id = result["id"] as! Double
                self.movies.append(Movie(imageString: imageString, title: movieTitle, description: movieDescription, releaseDate: releaseDate, bannerString: bannerString, id: id))
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as! DetailsViewController
        let cell = sender as! MoviesCell
        let indexPath = tableView.indexPath(for: cell)
        detailsVC.details = movies[(indexPath?.row)!]
        detailsVC.movieImage = cell.movieImageView.image
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell") as! MoviesCell
        
        //Configure the cell here
        cell.setUpCell(movies: movies, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

