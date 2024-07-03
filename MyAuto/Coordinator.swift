//
//  Coordinator.swift
//  MyAuto
//
//  Created by User on 08.04.24.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var tabBarController: UITabBarController { set get }
    var navigationController: BaseNavigationController { set get }
    
    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
}

class BaseCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    var tabBarController = UITabBarController()
    var navigationController = BaseNavigationController()
    var presentNavigationController = UINavigationController()
    
    var window = UIWindow(frame: UIScreen.main.bounds)
    
    // MARK: - Constructor
    init() {
        navigationController.view.backgroundColor = .white
    }
    
    func start() {
        fatalError("Start method must be implemented")
    }
    
    func start(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
        print(coordinator)
    }
    
    func didFinish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            print(childCoordinators)
            self.childCoordinators.remove(at: index)
        }
    }
}

