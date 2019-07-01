//
//  Geo.swift
//  MVVM Moya
//
//  Created by Arifin Firdaus on 6/24/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import Foundation

// MARK: - Geo
struct Geo: Codable {
    let lat: String?
    let lng: String?
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
}
