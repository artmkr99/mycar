//
//  CarModelListViewModel.swift
//  MyAuto
//
//  Created by User on 22.04.24.
//


import Foundation
import RxSwift
import RxCocoa

class CarModelListViewModel {
    
  private let networkService: CarInfoManager
  let modelsTableDataSource = BehaviorRelay<[CarModels]>(value: []) // Change from CarModel? to [CarModel]
  let bag = DisposeBag()

  var model: Any

  init(model: Any, manager: CarInfoManager) {
        self.model = model
        self.networkService = manager
        getModels(model: model)
    }
    
  func getModels(model: Any) {
    networkService.getCarModels(brandId: model)
    networkService.models
      .asObservable()
      .bind(to: modelsTableDataSource) // Bind the array of models
      .disposed(by: bag)
  }
}
