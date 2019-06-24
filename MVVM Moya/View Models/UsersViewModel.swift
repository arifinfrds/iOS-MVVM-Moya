//
//  UsersViewModel.swift
//  MVVM Moya
//
//  Created by Arifin Firdaus on 6/24/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import Foundation

class UsersViewModel {
    
    fileprivate let service = UserDataService()
    
    var users = [User]()
    var message: String?
    
    func fetchUsers(completion: @escaping ((ViewModelState) -> Void)) {
        service.requestFetchUsers { (users, error) in
            if let error = error {
                self.message = error.localizedDescription
                completion(.failure)
                return
            }
            self.users = users
            completion(.success)
        }
    }
    
}
