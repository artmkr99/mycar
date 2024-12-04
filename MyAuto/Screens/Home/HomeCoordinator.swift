//
//  HomeCoordinator.swift
//  MyAuto
//
//  Created by User on 01.10.24.
//

import Foundation
import UIKit

class HomeCoordinator: BaseCoordinator {

  override init() {
    super.init()
    start()
  }

  override func start() {
    let rootContorller = HomeViewController()
    let viewModel = HomeViewModel(networkManager: AppDelegate.appContext.serviceFactory.carInfoManager())
    rootContorller.viewModel = viewModel
    navigationController.setViewControllers([rootContorller], animated: true)
    rootContorller.tabBarItem = UITabBarItem(title: TabBarTypesEnum.home.title,
                                             image: TabBarTypesEnum.home.unselectIcon,
                                             selectedImage: TabBarTypesEnum.home.selectIcon)

    // Set custom view with logo
    let customView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    customView.backgroundColor = .red
    navigationController.navigationItem.titleView = customView


  }
}

