//
//  AnnouncementList.swift
//  MyAuto
//
//  Created by User on 20.11.24.
//

import Foundation

//// Root model for the response
//struct AnnouncementsResponse: Codable {
//    let message: String
//    let announcements: [Announcements]
//}
//
//struct Announcements: Codable {
//    let id: Int
//    let mark: String
//    let model: String
//    let region: String
//    let country: String
//    let year: String
//    let price: String
//    let milage: String
//    let color: String
//    let bodyType: String
//    let engineSize: String
//    let gearType: String
//    let fuelType: String
//    let isChange: String
//    let userId: Int
//    let createdAt: String
//    let updatedAt: String
//    let images: [AnnouncementImage]
//}
//
struct AnnouncementImage: Codable {
    let path: String?
    let createdAt: String?
    let announcementId: Int?
}

// MARK: - Welcome
struct AnnouncementsResponse: Codable {
    let message: String
    let announcements: [Announcements]
}

// MARK: - Announcement
struct Announcements: Codable {
    let milage, countryName, isChangeName: String
    let gearID, colorID, regionID: Int
    let engineSize, modelName: String
    let images: [AnnouncementImage]?
    let fuelID: Int
    let createdAt, regionName, fuelTypeName, year: String
    let bodyTypeName, brandName: String
    let brandID, id, countryID: Int
    let updatedAt: String
    let modelID, changeID: Int
    let colorName, gearTypeName, price: String
    let bodyID, userID: Int

    enum CodingKeys: String, CodingKey {
        case milage, countryName, isChangeName
        case gearID = "gearId"
        case colorID = "colorId"
        case regionID = "regionId"
        case engineSize, modelName, images
        case fuelID = "fuelId"
        case createdAt, regionName, fuelTypeName, year, bodyTypeName, brandName
        case brandID = "brandId"
        case id
        case countryID = "countryId"
        case updatedAt
        case modelID = "modelId"
        case changeID = "changeId"
        case colorName, gearTypeName, price
        case bodyID = "bodyId"
        case userID = "userId"
    }
}
