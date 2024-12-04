//
//  CarMarkModelSelectionViewFactory.swift
//  MyAuto
//
//  Created by User on 19.04.24.
//

import Foundation

enum CarMarkModelSelectionViewFactory {
    static func create(coordinator: CarInfoManager) -> CarMarkModelSelectionController {
        let controller = CarMarkModelSelectionController()
        let viewModel = CarMarkModelViewModel(carInfoManager: coordinator)
        controller.viewModel = viewModel
        
        return controller
    }
}
