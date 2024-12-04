//
//  CarColor.swift
//  MyAuto
//
//  Created by User on 27.11.24.
//

import Foundation

struct CarColor: Codable {
    let message: String
    let colors: [CarColors]
}

// MARK: - Color
struct CarColors: Codable {
    let id: Int
    let colorName: String
}
