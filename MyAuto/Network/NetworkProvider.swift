//
//  NetworkProvider.swift
//  MyAuto
//
//  Created by User on 28.10.24.
//

import Foundation
import RxSwift
import Moya

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

final class NetworkProvider: NetworkProviderProtocol {
  
  private let provider = MoyaProvider<NetworkEndPoints>(plugins: [
      NetworkLoggerPlugin(configuration: .init(
          formatter: .init(responseData: JSONResponseDataFormatter),
          logOptions: .verbose))
  ])

}

extension NetworkProvider: AuthNetworkProviderType {
  func signIn(login: String, password: String) -> RxSwift.Single<SignInModel> {
    return provider.rx
      .request(.signIn(login: login, password: password))
      .map(SignInModel.self)
  }

  func signUp(login: String, password: String) -> RxSwift.Single<SignUpModel> {
    return provider.rx
      .request(.signUp(number: login, password: password))
      .map(SignUpModel.self)
  }
}

extension NetworkProvider: CarDetailInfoProviderType {

  func getCarFuelTypes() -> RxSwift.Single<CarFuelType> {
    return provider.rx
      .request(.carsFuelType)
      .map(CarFuelType.self)
  }
  
  func getCarGearTypes() -> RxSwift.Single<CarGearType> {
    return provider.rx
      .request(.carsGearType)
      .map(CarGearType.self)
  }

  func getCarColors() -> RxSwift.Single<CarColor> {
    return provider.rx
      .request(.carsColor)
      .map(CarColor.self)
  }

  func getCarChangeTypes() -> RxSwift.Single<CarChangeType> {
    return provider.rx
      .request(.carsChangeTypes)
      .map(CarChangeType.self)
  }
  
  func getCarBrands() -> RxSwift.Single<CarBrands> {
    return provider.rx
      .request(.carsbrands)
      .map(CarBrands.self)
  }

  func getCarModels(brandId: Any) -> RxSwift.Single<CarModel> {
    return provider.rx
      .request(.carsModels(brandId: brandId))
      .map(CarModel.self)
  }

  func getCarBodyTypes() -> RxSwift.Single<CarBodyType> {
    return provider.rx
      .request(.carsBodyType)
      .map(CarBodyType.self)
  }

  func getRegions() -> RxSwift.Single<Region> {
    return provider.rx
      .request(.region)
      .map(Region.self)
  }

  func getCityes(cityID: String) -> RxSwift.Single<City> {
    return provider.rx
      .request(.cityes(cityId: cityID))
      .map(City.self)
  }

  func createAnnouncement(parameters: [String: Any], images: [UIImage]) -> Single<Response> {
      return provider.rx
      .request(.createAnnouncement(parameters: parameters, images: images))
  }

  func getAnnouncements(page: Int, limit: Int) -> Single<AnnouncementsResponse> {
    return provider.rx
      .request(.getAnnouncements(page: page, limit: limit))
      .map(AnnouncementsResponse.self)
  }
}
