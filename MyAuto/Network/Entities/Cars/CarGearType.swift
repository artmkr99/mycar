//
//  CarGearType.swift
//  MyAuto
//
//  Created by User on 15.11.24.
//

import Foundation


// MARK: - Welcome
struct CarGearType: Codable {
    let message: String
    let autoGear: [CarGearTypes]
}

// MARK: - AutoGear
struct CarGearTypes: Codable {
    let id: Int
    let type: String
}
