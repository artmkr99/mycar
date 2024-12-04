//
//  CarColorViewModel.swift
//  MyAuto
//
//  Created by User on 27.11.24.
//

import Foundation

import Foundation
import RxRelay
import RxSwift

class CarColorViewModel {
  private let networkService: CarInfoManager
  let modelsTableDataSource = BehaviorRelay<[CarColors]>(value: [])
  let bag = DisposeBag()

  init(carInfoManager: CarInfoManager) {
    self.networkService = carInfoManager
    //getColors()
  }

  func getColors() {
    networkService.getCarColors()
    networkService.carColors
      .asObservable()
      .bind(to: modelsTableDataSource)
      .disposed(by: bag)
  }
}
