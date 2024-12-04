//
//  CarBodyTypes.swift
//  MyAuto
//
//  Created by User on 15.11.24.
//

import Foundation

struct CarBodyType: Codable {
    let message: String
    let autoBody: [CarBodyTypes]
}

struct CarBodyTypes: Codable {
    let id: Int
    let type: String
}
