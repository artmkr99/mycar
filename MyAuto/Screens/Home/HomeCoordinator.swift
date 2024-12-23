//
//  HomeCoordinator.swift
//  MyAuto
//
//  Created by User on 01.10.24.
//

import Foundation
import UIKit
import RxSwift

class HomeCoordinator: BaseCoordinator {
  private let bag = DisposeBag()

  override init() {
    super.init()
    start()
  }

  override func start() {
    let rootContorller = HomeViewController()
    let viewModel = HomeViewModel(networkManager: AppDelegate.appContext.serviceFactory.carInfoManager())
    rootContorller.viewModel = viewModel

    viewModel.itemClicked
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] item in
        self?.handleItemSelection(item)
      })
      .disposed(by: bag)
    navigationController.setViewControllers([rootContorller], animated: true)
    rootContorller.tabBarItem = UITabBarItem(title: TabBarTypesEnum.home.title,
                                             image: TabBarTypesEnum.home.unselectIcon,
                                             selectedImage: TabBarTypesEnum.home.selectIcon)

    // Set custom view with logo
    let customView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    customView.backgroundColor = .red
    navigationController.navigationItem.titleView = customView
  }

  private func handleItemSelection(_ item: HomeTableItemsModel) {
      switch item {
      case .filter:
          let filterVC = FilterViewFactory.create(nav: navigationController)
          navigationController.pushViewController(filterVC, animated: true)

      case .announcements(let data):
          guard let announcement = data.first else { return }
//          let detailsVC = AnnouncementDetailsViewController(announcement: announcement)
//          navigationController.pushViewController(detailsVC, animated: true)
      }
  }
}

