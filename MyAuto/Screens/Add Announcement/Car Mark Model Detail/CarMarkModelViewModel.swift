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
    private let networkService: CarInfoManager
    let brandsTableDataSource = PublishRelay<[CarBrandModel]>()
    var isLoading = ActivityIndicator()

    let selectedBrandID = PublishSubject<Int>()
    private let bag = DisposeBag() // DisposeBag для управления подписками

   // private let coordinator: AddAnnouncementCoordinator
    //private var allBrands: [Brand] = [] // Store original brands


    init(carInfoManager: CarInfoManager) {
        self.networkService = carInfoManager
        getCarBrands()
    }
    
    func getCarBrands() {
      networkService.brands
        .asObservable()
        .bind(to: brandsTableDataSource)
        .disposed(by: bag)
    }

//    func filterBrands(searchText: String) {
//      let filteredBrands = allBrands.filter { brand in
//        brand.name.lowercased().contains(searchText.lowercased())
//      }
//      brandsTableDataSource.accept(filteredBrands) // Update the observable
//    }
}
