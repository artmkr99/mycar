//
//  CarBrands.swift
//  MyAuto
//
//  Created by User on 10.11.24.
//

import Foundation

struct CarBrands: Codable {
    let message: String
    let models: [CarBrandModel]
}

struct CarBrandModel: Codable {
    let id: Int
    let manufacturer, cyrillicName: String
}
