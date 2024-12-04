//
//  Cityes.swift
//  MyAuto
//
//  Created by User on 19.11.24.
//

import Foundation

struct City: Codable {
    let message: String
    let countries: [Cityes]
}

// MARK: - Country
struct Cityes: Codable {
    let id: Int
    let countryName: String
    let regionID: Int

    enum CodingKeys: String, CodingKey {
        case id, countryName
        case regionID = "regionId"
    }
}
