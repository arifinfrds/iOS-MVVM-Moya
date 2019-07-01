//
//  PostViewModel.swift
//  MVVM Moya
//
//  Created by Arifin Firdaus on 7/1/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import Foundation

class PostViewModel {
    
    fileprivate let service = PostDataService()
    
    var post: Post?
    var message: String?
    
    var sucessMessage: String? {
        get {
            if let id = post?.id {
                return "Success added post with id: \(id)"
            }
            return nil
        }
    }
    
    func addPost(with title: String, body: String, userId: Int, completion: @escaping ((ViewModelState) -> Void)) {
        service.addPost(title: title, body: body, userId: userId) { (post, error) in
            if let error = error {
                let message = error.localizedDescription
                self.message = message
                completion(.failure)
                return
            }
            self.post = post
            completion(.success)
        }
    }
    
}
