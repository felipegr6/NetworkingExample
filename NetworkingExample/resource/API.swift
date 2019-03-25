//
//  API.swift
//  NetworkingExample
//
//  Created by LOWCOST on 25/03/2019.
//  Copyright © 2019 PagSeguro. All rights reserved.
//

import Foundation
import Alamofire

enum API {
    case getPosts
    case getPostsComments(postId: Int)
    case getAlbums
    case getAlbumsPhotos(albumId: Int)
    case getPhotos
}

extension API {
    struct Constants {
        static let baseURL: String = "https://jsonplaceholder.typicode.com/"
    }
    
    var path: String {
        switch self {
        case .getPosts:
            return "posts"
        case .getPostsComments(let id):
            return "posts/\(id)/comments"
        case .getAlbums:
            return "albums"
        case .getAlbumsPhotos(let id):
            return "albums/\(id)/photos"
        case .getPhotos:
            return "photos"
        }
    }
    
    var url: String { return API.Constants.baseURL + path }
    
    var method: HTTPMethod {
        switch self {
//        case .newPost:
//            return .post
        default:
            return .get
        }
    }
    
    func request(
        params: [String: Any] = [:],
        callback:@escaping (_ data : [[String:Any]],
        _ error: Error?)->()) {
        
        let request = Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.prettyPrinted, headers: [:])
        
        request.validate().responseJSON { response in
            print("Status code: \(response.response?.statusCode ?? 0)")
            
            switch response.result {
                
            case .success:
                if let json = response.result.value as? [[String:Any]] {
                    callback(json, response.error)
                } else {
                    callback([], response.error)
                }
            
            case .failure(let error):
                callback([], error)
            }
        }
    }
}
