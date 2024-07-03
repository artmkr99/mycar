//
//  AddAnnouncementCoordinator.swift
//  MyAuto
//
//  Created by User on 08.04.24.
//

import UIKit
import RxCocoa
import RxSwift

final class AddAnnouncementCoordinator: BaseCoordinator {

  // MARK: - Private properties
  private let bag = DisposeBag()
  // MARK: - Public properties
  var router = PublishSubject<AddAnnouncementRoute>()

  // MARK: - Constructor
  override init() {
    super.init()

    start()
  }

  // MARK: - LifeCycle
  override func start() {

    let rootContorller = AddAnnouncementViewController()
    let viewModel = AddAnnouncementViewModel(coordinator: self)
    rootContorller.viewModel = viewModel
    rootContorller.tabBarItem = UITabBarItem(title: "Announcement", image: nil, tag: 1)

    // Routing
    router.asObservable()
      .observe(on: MainScheduler.asyncInstance)
      .subscribe(onNext: { [unowned self] route in
        switch route {
        case .carMark:
          let vc = CarMarkModelSelectionViewFactory.create(coordinator: self)
          self.navigationController.pushViewController(vc, animated: true)
        case .carModel:
          let vc = CarMarkModelSelectionViewFactory.create(coordinator: self)
          self.navigationController.pushViewController(vc, animated: true)

        case .carYearSelection:
          print(111)
        case .halfView:
          let vc = CarMilageViewFactory.create(type: .milage)
          vc.modalPresentationStyle = .overCurrentContext
          vc.delegate = rootContorller
          self.navigationController.present(vc, animated: false)

        case .carColor:
          let vc = CarColorViewController()
          vc.modalPresentationStyle = .formSheet
          self.navigationController.show(vc, sender: nil)

        case .carGearType:
          let vc = HalfTableViewViewFactory.create(type: .gearType)
          vc.modalPresentationStyle = .overCurrentContext
          self.navigationController.present(vc, animated: false)

        case .carBodyType:
          let vc = HalfTableViewViewFactory.create(type: .bodyType)
          vc.modalPresentationStyle = .overCurrentContext
          self.navigationController.present(vc, animated: false)

        case .isChange:
          let vc = HalfTableViewViewFactory.create(type: .changeType)
          vc.modalPresentationStyle = .overCurrentContext
          self.navigationController.present(vc, animated: false)

        case .carFuelType:
          let vc = HalfTableViewViewFactory.create(type: .fuelType)
          vc.modalPresentationStyle = .overCurrentContext
          self.navigationController.present(vc, animated: false)
        case .carPhotos:
          let vc = FinalAnnouncementController()
          self.navigationController.pushViewController(vc, animated: true)

        case .carPrice:
          let vc = CarMilageViewFactory.create(type: .price)
          vc.modalPresentationStyle = .overCurrentContext
          vc.delegate = rootContorller
          self.navigationController.present(vc, animated: false)

        }
      }).disposed(by: bag)


    navigationController.setViewControllers([rootContorller], animated: true)
  }
}
