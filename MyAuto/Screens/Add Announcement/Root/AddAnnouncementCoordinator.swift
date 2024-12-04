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
    rootContorller.tabBarItem = UITabBarItem(title: TabBarTypesEnum.addAnnouncement.title,
                                             image: TabBarTypesEnum.addAnnouncement.unselectIcon,
                                             selectedImage: TabBarTypesEnum.addAnnouncement.selectIcon)
    // Routing
    router.asObservable()
      .observe(on: MainScheduler.asyncInstance)
      .subscribe(onNext: { [unowned self] route in
        switch route {
        case .carMark:
          let vc = CarMarkModelSelectionViewFactory.create(coordinator: AppDelegate.appContext.serviceFactory.carInfoManager())
          self.navigationController.pushViewController(vc, animated: true)
        case .carModel:
          let vc = CarMarkModelSelectionViewFactory.create(coordinator: AppDelegate.appContext.serviceFactory.carInfoManager())
          self.navigationController.pushViewController(vc, animated: true)

        case .carYearSelection:
          print(111)
        case .halfView:
          let vc = CarMilageViewFactory.create(type: .milage)
          vc.modalPresentationStyle = .overCurrentContext
          vc.delegate = rootContorller
          self.navigationController.present(vc, animated: false)

        case .carColor:
          let vc = CarColorViewFactory.create()

          self.navigationController.pushViewController(vc, animated: true)

        case .carGearType:
          let vc = HalfTableViewViewFactory.create(type: .gearType)
          vc.delegate = rootContorller
          vc.modalPresentationStyle = .overCurrentContext
          self.navigationController.present(vc, animated: false)

        case .carBodyType:
          let vc = HalfTableViewViewFactory.create(type: .bodyType)
          vc.delegate = rootContorller
          vc.modalPresentationStyle = .overCurrentContext
          self.navigationController.present(vc, animated: false)

        case .isChange:
          let vc = HalfTableViewViewFactory.create(type: .changeType)
          vc.delegate = rootContorller
          vc.modalPresentationStyle = .overCurrentContext
          self.navigationController.present(vc, animated: false)

        case .carFuelType:
          let vc = HalfTableViewViewFactory.create(type: .fuelType)
          vc.delegate = rootContorller
          vc.modalPresentationStyle = .overCurrentContext
          self.navigationController.present(vc, animated: false)
        case .carPhotos:
          let vc = FinalAnnouncementViewFactory.create()
          self.navigationController.pushViewController(vc, animated: true)

        case .carPrice:
          let vc = CarMilageViewFactory.create(type: .price)
          vc.modalPresentationStyle = .overCurrentContext
          vc.delegate = rootContorller
          self.navigationController.present(vc, animated: false)

        case .carEngineSize:
          let vc = CarMilageViewFactory.create(type: .engineSize)
          vc.modalPresentationStyle = .overCurrentContext
          vc.delegate = rootContorller
          self.navigationController.present(vc, animated: false)
        case .region:
          let vc = RegionViewFactory.create()
          self.navigationController.pushViewController(vc, animated: true)
        }
      }).disposed(by: bag)


    navigationController.setViewControllers([rootContorller], animated: true)
  }
}
