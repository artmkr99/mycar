//
//  NetworkEndPoints.swift
//  MyAuto
//
//  Created by User on 28.10.24.
//

import Moya

enum NetworkEndPoints {

  // Auth
  case signIn(login: String, password: String)
  case signUp(number: String, password: String)

  // Cars
  case carsbrands
  case carsModels(brandId: Any)
  case carsBodyType
  case carsEngineType
  case carsFuelType
  case carsGearType
  case carsColor
  case carsChangeTypes
  case region
  case cityes(cityId: String)
  case createAnnouncement(parameters: [String: Any], images: [UIImage])
  case getAnnouncements(page: Int, limit: Int)

}

extension NetworkEndPoints: TargetType {
  var baseURL: URL {
    return AppKeys.baseURL
  }

  var path: String {
    switch self {

      // Auth
    case .signIn: return "users/login"
    case .signUp: return "users/registration"

      // Cars
    case .carsbrands: return "cars/brands"
    case .carsModels(let brandId): return "cars/models/\(brandId)"
    case .carsBodyType: return "cars/body"
    case .carsEngineType: return "cars/engine"
    case .carsFuelType: return "cars/fuel"
    case .carsGearType: return "cars/gear"
    case .carsColor: return "cars/colors"
    case .carsChangeTypes: return "cars/changes"
    case .region: return "regions/list"
    case .cityes(let cityId): return "regions/countries/\(cityId)"

      // Add announcement
    case .createAnnouncement: return "announcements/create"

      // Announcement list
    case .getAnnouncements: return "announcements/list"

    }
  }

  var method: Moya.Method {
    switch self {
    case .signIn, .signUp, .createAnnouncement: return .post

    default:
      return .get
    }
  }

  var task: Task {
    switch self {

    case .signIn(login: let login, password: let password):
      var parameters: [String: Any] = [:]
      parameters["number"] = login
      parameters["password"] = password

      return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    case .signUp(number: let login, password: let password):
      var parameters: [String: Any] = [:]
      parameters["number"] = login
      parameters["password"] = password

      return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)

    case .createAnnouncement(let parameters, let images):
      var formData = [MultipartFormData]()

      for (key, value) in parameters {
        if let stringValue = value as? String, let data = stringValue.data(using: .utf8) {
          formData.append(MultipartFormData(provider: .data(data), name: key))
        } else if let intValue = value as? Int {
          let data = "\(intValue)".data(using: .utf8)!
          formData.append(MultipartFormData(provider: .data(data), name: key))
        }
      }

      for (index, image) in images.enumerated() {
        if let imageData = image.jpegData(compressionQuality: 0.8) {
          let fileName = "image\(index).jpg"
          formData.append(MultipartFormData(provider: .data(imageData),
                                            name: "images",
                                            fileName: fileName,
                                            mimeType: "image/jpeg"))
        }
      }

      return .uploadMultipart(formData)

    case .getAnnouncements(let page, let limit):
      let parameters: [String: Any] = [
        "page": page,
        "limit": limit
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    default:
      return .requestPlain

    }
  }

  var headers: [String : String]? {
    switch self {
    case .signIn: return nil
    case .carsbrands:
      return ["Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibnVtYmVyIjoiKzM3NDk4MDAwMDAwIiwiaWF0IjoxNzMyNzE2Nzc3LCJleHAiOjE3NjQyNTI3Nzd9.q9ztUBEutHyJuyYbRTBnJtlWarZ7USJZZz0pBGaQbXU"]
    case .carsModels:
      return ["Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibnVtYmVyIjoiKzM3NDk4MDAwMDAwIiwiaWF0IjoxNzMyNzE2Nzc3LCJleHAiOjE3NjQyNTI3Nzd9.q9ztUBEutHyJuyYbRTBnJtlWarZ7USJZZz0pBGaQbXU"]
    default:
      return ["Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibnVtYmVyIjoiKzM3NDk4MDAwMDAwIiwiaWF0IjoxNzMyNzE2Nzc3LCJleHAiOjE3NjQyNTI3Nzd9.q9ztUBEutHyJuyYbRTBnJtlWarZ7USJZZz0pBGaQbXU"]
    }
  }
}
