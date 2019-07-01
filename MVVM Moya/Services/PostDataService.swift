//
//  PostDataService.swift
//  MVVM Moya
//
//  Created by Arifin Firdaus on 7/1/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import Foundation
import Moya

class PostDataService {
    
    fileprivate let provider = MoyaProvider<PostService>(endpointClosure: { (target: PostService) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Content-Type" : "charset=UTF-8"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    })
    
    func addPost(title: String, body: String, userId: Int, completion: @escaping ((Post?, Error?) -> Void)) {
        provider.request(.addPost(title: title, body: body, userId: userId)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let post = try decoder.decode(Post.self, from: response.data) // response from server
                    completion(post, nil)
                } catch (let error) {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
