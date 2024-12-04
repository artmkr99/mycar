//
//  ServiceFactory.swift
//  MyAuto
//
//  Created by User on 04.11.24.
//


import Foundation

protocol ServiceFactoryType {
    func accountManager() -> UserAccountManagerType
    func carInfoManager() -> CarInfoManager
}

final class ServiceFactory {

    private let network: NetworkProvider = NetworkProvider()

    // MARK: - Private

    private lazy var _accountManager = UserAccountManager(network: network.auth)
    private lazy var _carInfoManager = CarInfoManager(provider: network.carInfo)


    // MARK: - Public
  

    // MARK: - Constructor
  
    init() {

    }
}

// MARK: -
extension ServiceFactory: ServiceFactoryType {
  func carInfoManager() -> CarInfoManager {
    return _carInfoManager
  }

  func accountManager() -> UserAccountManagerType {
    return _accountManager
  }
}
