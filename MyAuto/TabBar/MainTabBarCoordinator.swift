//
//  MainTabBarCoordinator.swift
//  MyAuto
//
//  Created by User on 14.04.24.
//


import UIKit

final class MainTabBarCoordinator: BaseCoordinator {
    
    // MARK: - Private properties
    private let addAnnouncementCoordinator = AddAnnouncementCoordinator()
    private let homeCoordinator = HomeCoordinator()
    
    // MARK: - Constructor
    override init() {
      
    }
    
    override func start() {
        let rootViewController = MainTabBarViewController()
        
        rootViewController.setViewControllers([
            homeCoordinator.navigationController,
            addAnnouncementCoordinator.navigationController,
        ], animated: true)
        
        self.tabBarController = rootViewController
        self.window.rootViewController = self.tabBarController
        self.window.makeKeyAndVisible()
        
    }
}

