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
        
        title = "Movies"
        tableView.delegate = self
        tableView.dataSource = self
        
        downloadMovies {
            for index in 0..<self.data.count {
                let result = self.data[index]
                let imageString = result["poster_path"] as! String
                let movieTitle = result["title"] as! String
                let movieDescription = result["overview"] as! String
                self.movies.append(Movie(imageString: imageString, title: movieTitle, description: movieDescription))
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
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

    
    fileprivate func downloadMovies(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.data = dataDictionary["results"] as! [[String: Any]]
                completed()
            }
        }
        
        task.resume()
    }

}

