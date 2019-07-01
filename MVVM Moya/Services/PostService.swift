//
//  PostService.swift
//  MVVM Moya
//
//  Created by Arifin Firdaus on 7/1/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import Foundation
import Moya

enum PostService {
    
    case addPost(title: String, body: String, userId: Int)
    
}

extension PostService: TargetType {
    
    var baseURL: URL {
        let baseUrl = R.String.BaseURL.baseUrl
        guard let url = URL(string: baseUrl) else {
            fatalError("URL cannot be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .addPost(_, _, _):
            return "/posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addPost(_, _, _):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .addPost(let title, let body, let userId):
            var params: [String: Any] = [:]
            params["title"] = title
            params["body"] = body
            params["userId"] = userId
            
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
    
}
