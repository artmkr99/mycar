//
//  HalfTableViewViewFactory.swift
//  MyAuto
//
//  Created by User on 03.05.24.
//

import Foundation
enum HalfTableViewType {
    case gearType
    case fuelType
    case bodyType
    case changeType
}

enum HalfTableViewViewFactory {
    static func create(type: HalfTableViewType) -> HalfTableViewController {
        let controller = HalfTableViewController()
        let viewModel = HalfTableViewViewModel(type: type)
        controller.viewModel = viewModel
        
        return controller
    }
}
