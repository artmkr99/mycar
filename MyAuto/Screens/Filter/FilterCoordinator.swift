//
//  FilterCoordinator.swift
//  MyAuto
//
//  Created by User on 15.12.24.
//

import UIKit
import RxCocoa
import RxSwift

final class FilterCoordinator: BaseCoordinator {
    // MARK: - Private properties
    private let disposeBag = DisposeBag()

    // MARK: - Public properties
    var router = PublishSubject<FilterRoute>()

    // MARK: - Constructor
    override init() {
        super.init()
        start()
    }

    // MARK: - Lifecycle
    override func start() {
        // Убедимся, что start вызывается правильно
        print("FilterCoordinator started")

        let rootController = FilterController()
        let viewModel = FilterViewModel(coordinator: self)
        rootController.viewModel = viewModel

        // Маршрутизация по событиям router
        router.asObservable()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [unowned self] route in
                switch route {
                case .carMarkModelYear:
                  let vc = CarMarkModelSelectionViewFactory.create(coordinator: AppDelegate.appContext.serviceFactory.carInfoManager())

                  self.navigationController.pushViewController(vc, animated: false)

                case .mileage:
                    let vc = CarMilageViewFactory.create(type: .milage)
                    vc.modalPresentationStyle = .overCurrentContext
                    vc.delegate = rootController
                    self.navigationController.present(vc, animated: false)
                case .color:
                    let vc = CarColorViewFactory.create()
                    self.navigationController.pushViewController(vc, animated: true)
                case .engineSize:
                    let vc = CarMilageViewFactory.create(type: .engineSize)
                    vc.delegate = rootController
                    vc.modalPresentationStyle = .overCurrentContext
                    self.navigationController.present(vc, animated: false)
                case .exchange:
                    let vc = HalfTableViewViewFactory.create(type: .changeType)
                    vc.delegate = rootController
                    vc.modalPresentationStyle = .overCurrentContext
                    self.navigationController.present(vc, animated: false)
                case .region:
                    let vc = RegionViewFactory.create()
                    self.navigationController.pushViewController(vc, animated: true)
                case .bodyType:
                    let vc = HalfTableViewViewFactory.create(type: .bodyType)
                    vc.delegate = rootController
                    vc.modalPresentationStyle = .overCurrentContext
                    self.navigationController.present(vc, animated: false)
                case .gearBoxType:
                    let vc = HalfTableViewViewFactory.create(type: .gearType)
                    vc.delegate = rootController
                    vc.modalPresentationStyle = .overCurrentContext
                    self.navigationController.present(vc, animated: false)
                case .fuelType:
                    let vc = HalfTableViewViewFactory.create(type: .fuelType)
                    vc.delegate = rootController
                    vc.modalPresentationStyle = .overCurrentContext
                    self.navigationController.present(vc, animated: false)
                }
            })
            .disposed(by: disposeBag)

        // Устанавливаем root контроллер
        self.navigationController.setViewControllers([rootController], animated: true)
    }
}
