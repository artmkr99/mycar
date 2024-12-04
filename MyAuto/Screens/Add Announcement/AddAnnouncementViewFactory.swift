//
//  AddAnnouncementViewFactory.swift
//  MyAuto
//
//  Created by User on 08.04.24.
//

import Foundation

enum AddAnnouncementViewFactory {
    static func create() -> AddAnnouncementViewController {
        let controller = AddAnnouncementViewController()
        let viewModel = AddAnnouncementViewModel(coordinator: AddAnnouncementCoordinator())
        controller.viewModel = viewModel
        
        return controller
    }
}
