//
//  AppDelegate + Appereance.swift
//  MyAuto
//
//  Created by User on 03.10.24.
//


import UIKit

extension AppDelegate {
    func appearanceCustomize() {
        tableViewConfigure()
        tabBarAppearanceConfigure()
        navigationBarAppearanceConfigure()
    }

    func tableViewConfigure() {
        UITableView.appearance().tableFooterView = UIView()
        // UITableView.appearance().contentInsetAdjustmentBehavior = .never
    }

    func tabBarAppearanceConfigure() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().tintColor = UIColor.yellow
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }

    func navigationBarAppearanceConfigure() {
        UIBarButtonItem.appearance().tintColor = .white

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()

        navBarAppearance.shadowColor = .clear
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.backgroundImage = UIImage()

        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().prefersLargeTitles = false

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

        navBarAppearance.titleTextAttributes = [.strokeColor: UIColor.white,
                                                .foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.strokeColor: UIColor.white,
                                                     .foregroundColor: UIColor.white]
    }
}
