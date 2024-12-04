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
    static var appContext: AppContext!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAppContext()
        appCoordinator = AppCoordinator()
        appCoordinator.start()
        appearanceCustomize()

        return true
    }

  func setupAppContext() {
      AppDelegate.appContext = AppContext()
  }
}

