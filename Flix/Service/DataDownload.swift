//
//  DataDownload.swift
//  Flix
//
//  Created by hor kimleng on 2/13/19.
//  Copyright © 2019 hor kimleng. All rights reserved.
//

import Foundation

class DataDownload {
    private init() {}
    
    static var sharedInstance = DataDownload()

    var results = [[String:Any]]()
    
    func downloadMovies(url: URL, completion: @escaping ([[String:Any]]) -> ()) {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.results = dataDictionary["results"] as! [[String: Any]]
                completion(self.results)
            }
        }
        task.resume()
    }
}
