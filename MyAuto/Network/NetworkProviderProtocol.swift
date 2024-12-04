//
//  NetworkProviderProtocol.swift
//  MyAuto
//
//  Created by User on 28.10.24.
//

import RxSwift
import Moya

protocol AuthNetworkProviderType {
  func signIn(login: String, password: String) -> Single<SignInModel>
  func signUp(login: String, password: String) -> Single<SignUpModel>
}

protocol CarDetailInfoProviderType {
    func getCarBrands() -> Single<CarBrands>
    func getCarModels(brandId: Any) -> Single<CarModel>
    func getCarBodyTypes() -> Single<CarBodyType>
    func getCarFuelTypes() -> Single<CarFuelType>
    func getCarGearTypes() -> Single<CarGearType>
    func getCarColors() -> Single<CarColor>
    func getCarChangeTypes() -> Single<CarChangeType>
    func getRegions() -> Single<Region>
    func getCityes(cityID: String) -> Single<City>
    func createAnnouncement(parameters: [String: Any], images: [UIImage]) -> Single<Response>
    func getAnnouncements(page: Int, limit: Int) -> Single<AnnouncementsResponse>
}

protocol NetworkProviderProtocol {
    var auth: AuthNetworkProviderType { get }
    var carInfo: CarDetailInfoProviderType { get }
}

extension NetworkProviderProtocol where Self: AuthNetworkProviderType & CarDetailInfoProviderType {
    var auth: AuthNetworkProviderType { return self }
    var carInfo: CarDetailInfoProviderType { return self }
}

