//
//  AlbumResponse.swift
//  NetworkingExample
//
//  Created by LOWCOST on 25/03/2019.
//  Copyright © 2019 PagSeguro. All rights reserved.
//

import UIKit

class Album: NSObject {
    
    let userId: Int
    let id: Int
    let title: String
    
    init(args: [String:Any]) {
        self.userId = args["userId"] as? Int ?? -1
        self.id = args["id"] as? Int ?? -1
        self.title = args["title"] as? String ?? ""
    }
    
    static func getAlbums(callback: @escaping (_ albums : [Album], _ error: Error?) ->()) {
        
        API.getAlbums.request { (albumsJSON, error) in
            let albums = albumsJSON.compactMap { albumsJSON in Album(args: albumsJSON) }
            
            callback(albums, error)
        }
        
    }
}
