//
//  FinalAnnouncementViewFactory.swift
//  MyAuto
//
//  Created by User on 19.11.24.
//

import Foundation

enum FinalAnnouncementViewFactory {
  static func create() -> FinalAnnouncementController {
    let viewController = FinalAnnouncementController()
    let viewModel = FinalAnnouncementViewModel(networkService: AppDelegate.appContext.serviceFactory.carInfoManager())
    viewController.viewModel = viewModel
    return viewController
  }
}
