//
//  UserDataService.swift
//  MVVM Moya
//
//  Created by Arifin Firdaus on 6/24/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import Foundation
import Moya

class UserDataService {
    
    fileprivate let provider = MoyaProvider<UserService>(endpointClosure: { (target: UserService) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Content-Type" : "application/json"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    })
    
    func requestFetchUsers(completion: @escaping (([User], Error?) -> Void)) {
        provider.request(.fetchUsers) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let users = try decoder.decode([User].self, from: response.data)
                    completion(users, nil)
                } catch (let error) {
                    completion([], error)
                }
            case .failure(let error):
                completion([], error)
            }
        }
    }
    
    func requestFetchUser(with id: Int, completion: @escaping ((User?, Error?) -> Void)) {
        provider.request(.fetchUser(id: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(User.self, from: response.data)
                    completion(user, nil)
                } catch (let error) {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
