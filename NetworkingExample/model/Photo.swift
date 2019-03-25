//
//  Photo.swift
//  NetworkingExample
//
//  Created by LOWCOST on 25/03/2019.
//  Copyright © 2019 PagSeguro. All rights reserved.
//

import UIKit

class Photo: NSObject {
    
    let albumId: Int
    let id: Int
    let title: String
    let url: String?
    let thumbnailUrl: String?
    
    init(args: [String:Any]) {
        self.albumId = args["albumId"] as? Int ?? -1
        self.id = args["id"] as? Int ?? -1
        self.title = args["title"] as? String ?? ""
        self.url = args["url"] as? String ?? ""
        self.thumbnailUrl = args["thumbnailUrl"] as? String ?? ""
    }
    
    static func getPhotos(callback: @escaping (_ photos: [Photo], _ error: Error?) ->()) {
        
        API.getPhotos.request { (photosJSON, error) in
            let photos = photosJSON.compactMap { (photosJSON) in
                Photo(args: photosJSON)
            }
            callback(photos, error)
        }
    }
    
    static func getAlbumPhotos(_ id: Int, callback: @escaping (_ photos: [Photo], _ error: Error?) ->()) {
        
        API.getAlbumsPhotos(albumId: id).request { (photosJSON, error) in
            let photos = photosJSON.compactMap { photosJSON in
                Photo(args: photosJSON)
            }
            
            callback(photos, error)
        }
    }
}
