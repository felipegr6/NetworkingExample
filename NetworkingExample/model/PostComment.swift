//
//  PostCommentResponse.swift
//  NetworkingExample
//
//  Created by LOWCOST on 25/03/2019.
//  Copyright © 2019 PagSeguro. All rights reserved.
//

import UIKit

class PostComment: NSObject {
    
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
    
    init(args: [String: Any]) {
        self.postId = args["postId"] as? Int ?? -1
        self.id = args["id"] as? Int ?? -1
        self.name = args["name"] as? String ?? ""
        self.email = args["email"] as? String ?? ""
        self.body = args["body"] as? String ?? ""
    }
}
