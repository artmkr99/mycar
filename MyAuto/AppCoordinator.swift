//
//  AppCoordinator.swift
//  MyAuto
//
//  Created by User on 08.04.24.
//

import Foundation
import RxSwift
import RxCocoa

final class AppCoordinator: BaseCoordinator {
    
    lazy var mainTabBarCoordinator = MainTabBarCoordinator()
    lazy var authCoordinator = AuthorizationCoordinator(coordinator: self)
    
    // MARK: - Constructor
    override init() {
    }
    
    // MARK: - LifeCycle
    override func start() {
        
        setRootCoordinator()
    }
    
    func signIn() {
        self.didFinish(coordinator: authCoordinator)
        self.start(coordinator: mainTabBarCoordinator)
    }
    
    func signUp() {
        self.didFinish(coordinator: mainTabBarCoordinator)
        self.start(coordinator: authCoordinator)
    }
    
    func logout() {
        self.didFinish(coordinator: mainTabBarCoordinator)
        self.start(coordinator: authCoordinator)
        UserDefaults.standard.removeObject(forKey: "userAccessToken")
        UserDefaults.standard.synchronize()
    }
}

// MARK: - Private methods
private extension AppCoordinator {
    func setRootCoordinator() {
        start(coordinator: mainTabBarCoordinator)
    }
}
