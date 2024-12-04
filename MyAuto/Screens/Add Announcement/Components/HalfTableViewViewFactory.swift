//
//  HalfTableViewViewFactory.swift
//  MyAuto
//
//  Created by User on 03.05.24.
//

import Foundation

enum HalfTableViewViewFactory {
    static func create(type: HalfTableViewType) -> HalfTableViewController {
        let controller = HalfTableViewController()
        let viewModel = HalfTableViewViewModel(type: type,
                                               networkService: AppDelegate.appContext.serviceFactory.carInfoManager())
        controller.viewModel = viewModel
        
        return controller
    }
}
