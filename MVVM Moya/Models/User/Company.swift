//
//  Company.swift
//  MVVM Moya
//
//  Created by Arifin Firdaus on 6/24/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import Foundation

// MARK: - Company
struct Company: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case catchPhrase = "catchPhrase"
        case bs = "bs"
    }
}
