//
//  NetworkManager.swift
//  TvShows_prj
//
//  Created by EricM on 9/10/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation

class NetworkManager {
//var test = TVShows()
    // TODO: update this to cache
    private init() {}
    
    /// singleton
    static let shared = NetworkManager()
    
    //Performs GET requests for any URL
    //Parameters: URL as a string
    //Completion: Result with Data in success, AppError in failure
    
    func getPokemon(tvShow: TVShows, completionHandler: @escaping (Result<TVShows, AppError>) -> Void){
        
        let urlStr = "http://api.tvmaze.com/shows"
        let urlStr2 = "http://api.tvmaze.com/shows/\(tvShow.id)/episodes"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badUrl))
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(.noDataError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noDataError))
                return
            }
            
            do {
                let tvData = try JSONDecoder().decode(TVShows.self, from: data)
                completionHandler(.success(tvData))
            }
            catch {
                print(error)
                completionHandler(.failure(.networkError))
            }
            }.resume()
    }
}
