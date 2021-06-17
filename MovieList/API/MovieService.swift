//
//  MovieService.swift
//  MovieList
//
//  Created by cevhersirin on 16.06.2021.
//

import Foundation

open class MovieAPI {
    
    
     open class func movies(page: Int, completion: @escaping (Movie) -> ()){
        let path = Environment.basePath + "&page=\(page)"
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: path)!)){ (data, req, error) in
            
            do {
                if data != nil {
                    let result = try JSONDecoder().decode(Movie.self, from: data!)
                    completion(result)
                }
            } catch {
                print(error.localizedDescription)
                
            }
            
        }.resume()
    }
}
