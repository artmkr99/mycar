//
//  CarInfoManager.swift
//  MyAuto
//
//  Created by User on 10.11.24.
//

import RxSwift
import RxRelay

final class CarInfoManager {

  // MARK: - Private properties
  private let bag = DisposeBag()
  private let provider: CarDetailInfoProviderType

  let brands = BehaviorRelay<[CarBrandModel]>(value: [])
  let models = BehaviorRelay<[CarModels]>(value: [])

  let bodyTypes = BehaviorRelay<[CarBodyTypes]>(value: [])
  let fuelTypes = BehaviorRelay<[CarFuelTypes]>(value: [])
  let gearTypes = BehaviorRelay<[CarGearTypes]>(value: [])
  let carColors = BehaviorRelay<[CarColors]>(value: [])
  let changeTypes = BehaviorRelay<[CarChangeTypes]>(value: [])
  let regions = BehaviorRelay<[Regions]>(value: [])
  let cityes = BehaviorRelay<[Cityes]>(value: [])
  let announcements = BehaviorRelay<[Announcements]>(value: [])

  // MARK: - Constructor
  init(provider: CarDetailInfoProviderType) {
    self.provider = provider

    provider.getCarBrands()
      .asObservable()
      .subscribe(onNext: { carBrands in
        self.brands.accept(carBrands.models)
      }, onError: { error in
        // Обработка ошибок
        print("Error fetching car brands: \(error)")
      })
      .disposed(by: bag)
  }

  func getCarModels(brandId: Any) {
    provider.getCarModels(brandId: brandId)
      .asObservable()
      .subscribe(onNext: { response in
        self.models.accept(response.models)
        print("Fetched car models: \(response.models)")
      }, onError: { error in
        print("Error fetching car models: \(error)")
      })
      .disposed(by: bag)
  }

  func getCarBodyTypes() {
    provider.getCarBodyTypes().asObservable()
      .subscribe(onNext: { response in
        self.bodyTypes.accept(response.autoBody)
      }, onError: { error in
        print("Error fetching car models: \(error)")
      })
      .disposed(by: bag)
  }

  func getCarFuelType() {
    provider.getCarFuelTypes().asObservable()
      .subscribe(onNext: { response in
        self.fuelTypes.accept(response.autoFuel)
      }, onError: { error in
        print("Error fetching car models: \(error)")
      })
      .disposed(by: bag)
  }

  func getCarGearType() {
    provider.getCarGearTypes().asObservable()
      .subscribe(onNext: { response in
        self.gearTypes.accept(response.autoGear)
      }, onError: { error in
        print("Error fetching car models: \(error)")
      })
      .disposed(by: bag)
  }

  func getCarColors() {
    provider.getCarColors().asObservable()
      .subscribe(onNext: { response in
        self.carColors.accept(response.colors)
      }, onError: { error in
        print("Error fetching car models: \(error)")
      })
      .disposed(by: bag)
  }

  func getCarChangeType() {
    provider.getCarChangeTypes().asObservable()
      .subscribe(onNext: { response in
        self.changeTypes.accept(response.isChange)
      }, onError: { error in
        print("Error fetching car models: \(error)")
      })
      .disposed(by: bag)
  }

  func getRegions() {
    provider.getRegions().asObservable()
      .subscribe(onNext: { response in
        self.regions.accept(response.regions)
      }, onError: { error in
        print("Error fetching car models: \(error)")
      })
      .disposed(by: bag)
  }

  func getCityes(cityID: String) {
    provider.getCityes(cityID: cityID).asObservable()
      .subscribe(onNext: { response in
        self.cityes.accept(response.countries)
      }, onError: { error in
        print("Error fetching car models: \(error)")
      })
      .disposed(by: bag)
  }

  func createAnnouncement(parameters: [String : Any], images: [UIImage]) {
    provider.createAnnouncement(parameters: parameters, images: images)
      .subscribe({ resp in
        print(parameters)
        print(resp)
      })
      .disposed(by: bag)
  }

  func getAnnouncements() {
    provider.getAnnouncements(page: 1, limit: 10).asObservable()
      .subscribe(onNext: { response in
        self.announcements.accept(response.announcements)
      }, onError: { error in
        print("Error fetching car models: \(error)")
      })
      .disposed(by: bag)
  }
}
