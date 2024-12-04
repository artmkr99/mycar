//
//  RegionViewFactory.swift
//  MyAuto
//
//  Created by User on 19.11.24.
//

import UIKit

enum CityViewFactory {
  static func create(cityID: String) -> CityViewController {
    let controller = CityViewController()
    let viewModel = CityViewModel(carInfoManager: AppDelegate.appContext.serviceFactory.carInfoManager(), cityID: cityID)
    controller.viewModel = viewModel

    return controller
  }
}

