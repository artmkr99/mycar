////
////  Model.swift
////  MyAuto
////
////  Created by User on 19.04.24.
////
//
//import Foundation
//
//// MARK: - Welcome
//struct CarBrand: Codable {
//    let brands: [Brand]
//}
//
//// MARK: - Brand
//struct Brand: Codable {
//    let cyrillicName, id, name: String
//
//    enum CodingKeys: String, CodingKey {
//        case cyrillicName = "cyrillic_name"
//        case id, name
//    }
//}
//
//struct CarModel: Codable {
//    let models: [Model]
//}
//
//// MARK: - Model
//struct Model: Codable {
//    let brandID: String
//    let name: String
//    let yearFrom: Int
//    let yearTo: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case brandID = "brand_id"
//        case name
//        case yearFrom = "year_from"
//        case yearTo = "year_to"
//    }
//}
