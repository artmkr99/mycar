//
//  AnnouncementDataCollectorManager.swift
//  MyAuto
//
//  Created by User on 19.11.24.
//

import Foundation
import UIKit

class AnnouncementDataCollectorManager {
    static var shared = AnnouncementDataCollectorManager()
    var paramNameManager = CarAnnouncementCollector.shared

    var engineSize: String?
    var colorId: Int?
    var price: String? //
    var gearType: Int? //
    var model: Int? //
    var mark: Int? //
    var milage: String? //
    var fuelType: Int? //
    var bodyType: Int? //
    var isChange: Int? //
    var region: Int? //
    var country: Int? //
    var year: String? //
    var carImage: [UIImage]?

  // Mark: - Model names
    var brandName: String?
    var modelName: String?
    var colorName: String?
    var bodyTypeName: String?
    var gearTypeName: String?
    var fuelTypeName: String?
    var isChangeName: String?
    var regionName: String?
    var countryName: String?


  func setNameParams() {
    brandName = paramNameManager.carBrand
    modelName = paramNameManager.carModel
    gearTypeName = paramNameManager.carGearType
    colorName = paramNameManager.carColor
    bodyTypeName = paramNameManager.carBodyType
    fuelTypeName = paramNameManager.carFuelType
    isChangeName = paramNameManager.carIsChange
    carImage = paramNameManager.carImages
  }
  
  func buildParameters() -> [String: Any] {
    setNameParams()
    return [
      "engineSize": engineSize ?? "",
      "colorId": 1,
      "colorName": colorName ?? "",
      "price": price ?? "",
      "gearId": 1,
      "brandId": model ?? 1,
      "modelId": mark ?? 1,
      "milage": milage ?? "",
      "fuelId": 1,
      "bodyId": 1,
      "changeId": 1,
      "regionId": 1,
      "countryId": 1,
      "year": year ?? "",
      "brandName": brandName ?? "",
      "modelName": modelName ?? "",
      "gearTypeName": gearTypeName ?? "",
      "bodyTypeName": bodyTypeName ?? "",
      "fuelTypeName": fuelTypeName ?? "",
      "isChangeName": isChangeName ?? "",
      "regionName": regionName ?? "",
      "countryName": countryName ?? "",
      "images": carImage,
      "description": "sdsdsd"
    ]
  }
}
