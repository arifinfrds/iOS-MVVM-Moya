//
//  UserService.swift
//  MVVM Moya
//
//  Created by Arifin Firdaus on 6/24/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import Foundation
import Moya

enum UserService {
    
    case fetchUsers
    
    case fetchUser(id: Int)
    
}

extension UserService: TargetType {
    
    var baseURL: URL {
        let baseUrl = R.String.BaseURL.baseUrl
        guard let url = URL(string: baseUrl) else {
            fatalError("URL cannot be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .fetchUsers:
            return "/users"
        case .fetchUser(let id):
            return "/users/\(id)"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchUsers:
            return .get
        case .fetchUser(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
