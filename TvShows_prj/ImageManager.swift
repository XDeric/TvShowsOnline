//
//  ImageManager.swift
//  TvShows_prj
//
//  Created by EricM on 9/10/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    
    private init() {}
    
    static let shared = ImageHelper()
    
    
    func getImage(urlStr: String, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(AppError.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(AppError.noDataError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(AppError.noDataError))
                return
            }
            
            
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(AppError.noDataError))
                return
            }
            
            completionHandler(.success(image))
            
            
            }.resume()
    }
}
