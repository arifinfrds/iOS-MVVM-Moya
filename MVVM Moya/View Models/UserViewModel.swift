//
//  UserViewModel.swift
//  MVVM Moya
//
//  Created by Arifin Firdaus on 6/28/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import Foundation

class UserViewModel {
    
    var userId: Int?
    
    fileprivate let service = UserDataService()
    
    var user: User?
    var message: String?
    
    
    func fetchUser(with id: Int, completion: @escaping ((ViewModelState) -> Void)) {
        service.requestFetchUser(with: id) { (user, error) in
            if let error = error {
                self.message = error.localizedDescription
                completion(.failure)
                return
            }
            self.user = user
            self.userId = user?.id
            completion(.success)
        }
    }
    
    func getUsername() -> String? {
        guard let username = user?.username else { return nil }
        return "@\(username)"
    }
    
    func getAddress() -> String? {
        guard
            let address = user?.address,
            let street = address.street,
            let suite = address.suite,
            let city = address.city,
            let zipCode = address.zipcode else {
                return nil
        }
        let fullAddress = "\(street), \(suite), \(city), \(zipCode)"
        return fullAddress
    }
    
}
