//
//  CityViewModel.swift
//  MyAuto
//
//  Created by User on 19.11.24.
//

import Foundation
import RxRelay
import RxSwift

class CityViewModel {
  private let networkService: CarInfoManager
  let modelsTableDataSource = BehaviorRelay<[Cityes]>(value: [])
  let bag = DisposeBag()

  init(carInfoManager: CarInfoManager, cityID: String) {
    self.networkService = carInfoManager
    getCityes(cityID: cityID)
  }

  func getCityes(cityID: String) {
    networkService.getCityes(cityID: cityID)
    networkService.cityes
      .asObservable()
      .bind(to: modelsTableDataSource)
      .disposed(by: bag)
  }
}
