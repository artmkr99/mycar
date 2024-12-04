//
//  CarModels.swift
//  MyAuto
//
//  Created by User on 10.11.24.
//

import Foundation

// MARK: - Welcome
struct CarModel: Codable {
    let message: String
    let models: [CarModels]
}

// MARK: - Model
struct CarModels: Codable {
    let id: Int
    let model: String
    let yearFrom: Int
    let yearTo: Int?
}


