//
//  FinalAnnouncementViewModel.swift
//  MyAuto
//
//  Created by User on 19.11.24.
//

import UIKit

class FinalAnnouncementViewModel {
  private let networkService: CarInfoManager

  init(networkService: CarInfoManager) {
    self.networkService = networkService
  }

  func createAnnouncement() {
    let manager = AnnouncementDataCollectorManager.shared
    let parameters = manager.buildParameters()
    print(parameters)
    guard let images = CarAnnouncementCollector.shared.carImages else { return }

    networkService.createAnnouncement(parameters: parameters, images: images)
  }
}
