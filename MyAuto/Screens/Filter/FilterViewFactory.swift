//
//  FilterViewFactory.swift
//  MyAuto
//
//  Created by User on 28.11.24.
//

import UIKit

enum FilterViewFactory {
  static func create() -> UIViewController {
    let viewController = FilterController()
    let viewModel = FilterViewModel()
    viewController.viewModel = viewModel
    return viewController
  }
}
