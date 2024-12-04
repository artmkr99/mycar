//
//  Region.swift
//  MyAuto
//
//  Created by User on 19.11.24.
//

import Foundation

struct Region: Codable {
    let message: String
    let regions: [Regions]
}

// MARK: - Region
struct Regions: Codable {
    let id: Int
    let regionName: String
}
