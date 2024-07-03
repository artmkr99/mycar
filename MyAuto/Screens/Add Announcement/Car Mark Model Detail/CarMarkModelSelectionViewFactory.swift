//
//  CarMarkModelSelectionViewFactory.swift
//  MyAuto
//
//  Created by User on 19.04.24.
//

import Foundation

enum CarMarkModelSelectionViewFactory {
    static func create(coordinator: AddAnnouncementCoordinator) -> CarMarkModelSelectionController {
        let controller = CarMarkModelSelectionController()
        let viewModel = CarMarkModelViewModel(coordinator: coordinator)
        controller.viewModel = viewModel
        
        return controller
    }
}
