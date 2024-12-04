//
//  RegionViewFactory.swift
//  MyAuto
//
//  Created by User on 19.11.24.
//

import UIKit

enum RegionViewFactory {
  static func create() -> RegionController {
    let controller = RegionController()
    let viewModel = RegionViewModel(carInfoManager: AppDelegate.appContext.serviceFactory.carInfoManager())
    controller.viewModel = viewModel

    return controller
  }
}

