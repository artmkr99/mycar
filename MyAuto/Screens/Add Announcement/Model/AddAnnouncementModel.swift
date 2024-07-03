//
//  AddAnnouncementModel.swift
//  MyAuto
//
//  Created by User on 02.04.24.
//

enum AddAnnouncementTableSection {
    case autoInfo
    case anotherInfo
    case isChangeBlock
    
    var title: String {
        switch self {
        case .autoInfo: return "autoInfo"
        case .anotherInfo: return "anotherInfo"
        case .isChangeBlock: return "isChange"
        }
    }
}

enum AddAnnouncementTableItems {
    
    case carMark
    case carModel
    case carYear
    case carMilage
    case carColor
    case carBodyType
    case carEngineSize
    case carGearType
    case carFuelType
    case isChange
    case carPhotos
    case carPrice

    var title: String {
        switch self {
            
        case .carMark: return "Mark"
        case .carModel: return "Model"
        case .carYear: return "Select car year"
        case .carMilage: return "Write milage"
        case .carColor: return "Select Color"
        case .carBodyType: return "Select Body type"
        case .carEngineSize: return "Select engine size"
        case .carGearType: return "Select gear type"
        case .carFuelType: return "Select fuel type"
        case .isChange: return "isChange"
        case .carPhotos: return "Car photos"
        case .carPrice: return "Price"

        }
    }
    
    var value: String {
        switch self {
            
        case .carMark:
            return "carmark"
        case .carModel:
            return "carModel"
        case .carYear:
            return "carYear"
        case .carMilage:
            return "carMilage"
        case .carColor:
            return "carMilage"
        case .carBodyType:
            return "carMilage"
        case .carEngineSize:
            return "carMilage"
        case .carGearType:
            return "carMilage"
        case .carFuelType:
            return "carMilage"
        case .isChange:
            return "carMilage"
        case .carPhotos:
            return "carMilage"
        case .carPrice:
          return "carPrice"
        }
    }
}
