//
//  AuthorizationCoordinator.swift
//  MyAuto
//
//  Created by User on 14.04.24.
//

import UIKit
import RxSwift

final class AuthorizationCoordinator: BaseCoordinator {
    
    var router = PublishSubject<AuthorizationRoute>()
    
    // MARK: - Private properties
    private var bag = DisposeBag()
    private let coordinator: AppCoordinator
    private let accountManager: UserAccountManagerType

    // MARK: - Constructor
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        self.accountManager = AppDelegate.appContext.serviceFactory.accountManager()
        super.init()
    }
    
    override func start() {
        bag = DisposeBag()
        let rootViewController = LoginViewController()
        let viewModel = LoginViewModel(accountManager: accountManager,
                                       coordinator: self)
        rootViewController.viewModel = viewModel

        router.asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] route in
                switch route {
                
                case .signin:
                    self.navigationController.setViewControllers([rootViewController], animated: true)
                    print([rootViewController])
                case .signup:
                  let viewController = SignUpViewController()
                  let viewModel = SignUpViewModel(accountManager: self.accountManager, coordinator: self)
                  viewController.viewModel = viewModel
                  self.navigationController.pushViewController(viewController, animated: true)
                  print("SignUPCoordinatorNavigateTo")
                case .home:
                    self.coordinator.signIn()
                }
            })
            .disposed(by: bag)
        
        self.navigationController.setViewControllers([rootViewController], animated: true)
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    }
}

enum AuthorizationRoute {
    case signin
    case signup
    case home
}
