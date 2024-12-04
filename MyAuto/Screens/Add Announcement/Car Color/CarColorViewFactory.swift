//
//  CarColorViewFactory.swift
//  MyAuto
//
//  Created by User on 27.11.24.
//

import Foundation
import UIKit

enum CarColorViewFactory {
  static func create() -> UIViewController {
    let viewController = CarColorViewController()
    let viewModel = CarColorViewModel(carInfoManager: AppContext().serviceFactory.carInfoManager())
    viewController.viewModel = viewModel

    return viewController
  }
}
