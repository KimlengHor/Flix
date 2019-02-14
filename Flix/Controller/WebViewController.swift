//
//  WebViewController.swift
//  Flix
//
//  Created by hor kimleng on 2/14/19.
//  Copyright © 2019 hor kimleng. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    //IBOulets
    @IBOutlet weak var webView: WKWebView!
    
    //Variables
    var id = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyUrl = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")
        if let keyUrl = keyUrl {
            DataDownload.sharedInstance.downloadMovies(url: keyUrl) { (results) in
                let result = results[0]
                let key = result["key"] as! String
                let url = URL(string: "https://www.youtube.com/watch?v=\(key)")
                if let url = url {
                    let request = URLRequest(url: url)
                    self.webView.load(request)
                }
            }
        }
        
    }
}
