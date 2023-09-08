//
//  NetworkManager.swift
//  News
//
//  Created by Eric Huang on 5/23/20.
//  Copyright © 2020 Eric Huang. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var posts = [Post]()
    func fetchMessage(message:String){
        posts.append(Post(id: String(posts.count), title: message))
    
    }
}
