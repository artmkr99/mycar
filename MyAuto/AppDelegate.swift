//
//  AppDelegate.swift
//  MyAuto
//
//  Created by User on 12.05.23.
//

import UIKit
import SnapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator = AppCoordinator()
        appCoordinator.start()
        
        return true
    }

}

