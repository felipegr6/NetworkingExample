//
//  PostResponse.swift
//  NetworkingExample
//
//  Created by LOWCOST on 25/03/2019.
//  Copyright © 2019 PagSeguro. All rights reserved.
//

import UIKit

class Post: NSObject {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    init(args:[String:Any]) {
        userId = args["userId"] as? Int ?? -1
        id = args["userId"] as? Int ?? -1
        title = args["userId"] as? String ?? ""
        body = args["userId"] as? String ?? ""
    }
}
