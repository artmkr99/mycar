//
//  RegionVIewModel.swift
//  MyAuto
//
//  Created by User on 19.11.24.
//

import Foundation
import RxRelay
import RxSwift

class RegionViewModel {
  private let networkService: CarInfoManager
  let modelsTableDataSource = BehaviorRelay<[Regions]>(value: [])
  let bag = DisposeBag()

  init(carInfoManager: CarInfoManager) {
    self.networkService = carInfoManager
    getRegions()
  }

  func getRegions() {
    networkService.getRegions()
    networkService.regions
      .asObservable()
      .bind(to: modelsTableDataSource) 
      .disposed(by: bag)
  }
}
