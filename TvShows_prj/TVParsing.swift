//
//  TVParsing.swift
//  TvShows_prj
//
//  Created by EricM on 9/10/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation

//struct Television: Codable{
//    let show: TVShows
//}
    struct TVShows: Codable{
        let id: Int
        let name: String
        let rating: Avg?
        let image: Image?
    }
    
    struct Avg: Codable{
        let average: Double?
    }
    
    struct Image: Codable {
        let medium: String
    }


//------------------------------------------------------------------------
struct SeasonEpisodes: Codable{
    let name: String
    let season: Int
    let number: Int
    let summary: String?
    let image: Image?
    
    struct Image: Codable {
        let medium: String
    }
}

