//
//  CarMarkModelViewModel.swift
//  MyAuto
//
//  Created by User on 19.04.24.
//

import Foundation
import RxSwift
import RxCocoa


class CarMarkModelViewModel {
    private let networkService = NetworkService()
    let brandsTableDataSource = PublishRelay<[Brand]>()
    
    let selectedBrandID = PublishSubject<String>()
    private let coordinator: AddAnnouncementCoordinator

    init(coordinator: AddAnnouncementCoordinator) {
        self.coordinator = coordinator
        getCarBrands()
    }
    
    func getCarBrands() {
        networkService.getCarBrands { [weak self] result in
            switch result {
            case .success(let carBrands):
                self?.brandsTableDataSource.accept(carBrands.brands)
                
            case .failure(let error):
                print("Failed to retrieve car brands: \(error)")
            }
        }
    }
}
