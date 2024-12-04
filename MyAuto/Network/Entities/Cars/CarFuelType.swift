//
//  CarFuelType.swift
//  MyAuto
//
//  Created by User on 15.11.24.
//

import Foundation

struct CarFuelType: Codable {
    let message: String
    let autoFuel: [CarFuelTypes]
}

// MARK: - AutoFuel
struct CarFuelTypes: Codable {
    let id: Int
    let type: String
}
