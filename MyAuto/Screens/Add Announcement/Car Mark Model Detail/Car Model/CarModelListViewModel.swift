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
    
    private let networkService = NetworkService()
    let modelsTableDataSource = PublishRelay<[Model]>()
    var model: String

    init(model: String) {
        self.model = model
        getModels(model: model)
    }
    
    func getModels(model: String) {
        networkService.getCarModels(brandID: model) { [weak self] result in
            switch result {
            case .success(let carModels):
                self?.modelsTableDataSource.accept(carModels.models)

            case .failure(let error):
                print("Failed to retrieve car brands: \(error)")
            }
        }
    }
}
