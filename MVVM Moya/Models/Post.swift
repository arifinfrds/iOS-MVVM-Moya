//
//  Post.swift
//  MVVM Moya
//
//  Created by Arifin Firdaus on 7/1/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let id: Int?
    let title: String?
    let body: String?
    let userID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case body = "body"
        case userID = "userId"
    }
}

