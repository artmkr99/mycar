//
//  FilterViewFactory.swift
//  MyAuto
//
//  Created by User on 28.11.24.
//

import UIKit

enum FilterViewFactory {
  static func create(nav: BaseNavigationController) -> UIViewController {
    let viewController = FilterController()
    let coordinator = FilterCoordinator()
    coordinator.navigationController = nav
    let viewModel = FilterViewModel(coordinator: coordinator)
    viewController.viewModel = viewModel
    return viewController
  }
}
