//
//  AppContex.swift
//  MyAuto
//
//  Created by User on 04.11.24.
//


import Foundation

final class AppContext {

    let serviceFactory: ServiceFactoryType

    init() {
        serviceFactory = ServiceFactory()
    }
}
