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
        
    // MARK: - Constructor
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator        
        super.init()
    }
    
    override func start() {
        bag = DisposeBag()
        let rootViewController = LoginViewController()
        print(navigationController.viewControllers)

        router.asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] route in
                switch route {
                
                case .signin:
                    self.navigationController.setViewControllers([rootViewController], animated: true)
                    print([rootViewController])
                }
            })
            .disposed(by: bag)
        

        self.navigationController.setViewControllers([rootViewController], animated: true)
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
        print(navigationController.viewControllers)
    }
}

enum AuthorizationRoute {
    case signin
}
