//
//  HomeViewModel.swift
//  MyAuto
//
//  Created by User on 20.11.24.
//

import Foundation
import RxRelay
import RxSwift

class HomeViewModel {
  private let bag = DisposeBag()

  var networkManager: CarInfoManager!
  var tableDataSource = PublishRelay<[Announcements]>()
  var isLoading = ActivityIndicator()

  init(networkManager: CarInfoManager) {
    self.networkManager = networkManager
    getAnnouncement()
  }

  func getAnnouncement() {
    self.networkManager.getAnnouncements()
    self.networkManager.announcements
      //.trackActivity(isLoading) // Отслеживаем загрузку
      .asObservable()  // Преобразуем Single в Observable
      .bind(to: tableDataSource)
      .disposed(by: bag)
  }
}
