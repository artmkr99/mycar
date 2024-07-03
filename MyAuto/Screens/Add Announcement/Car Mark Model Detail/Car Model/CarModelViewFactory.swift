//
//  CarModelViewFactory.swift
//  MyAuto
//
//  Created by User on 22.04.24.
//

import Foundation

enum CarModelViewFactory {
    static func create(model: String) -> CarModelListViewController {
        let controller = CarModelListViewController()
        let viewModel = CarModelListViewModel(model: model)
        controller.viewModel = viewModel
        
        return controller
    }
}
