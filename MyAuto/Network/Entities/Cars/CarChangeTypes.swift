//
//  CarChangeTypes.swift
//  MyAuto
//
//  Created by User on 15.11.24.
//

import Foundation

struct CarChangeType: Codable {
    let message: String
    let isChange: [CarChangeTypes]
}

// MARK: - IsChange
struct CarChangeTypes: Codable {
    let id: Int
    let type: String
}
