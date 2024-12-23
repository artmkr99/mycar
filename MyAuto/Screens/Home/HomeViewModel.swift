//
//  HomeViewModel.swift
//  MyAuto
//
//  Created by User on 20.11.24.
//

import Foundation
import RxRelay
import RxSwift

enum HomeTableItemsModel {
  case filter
  case announcements(data: [Announcements])
}

class HomeViewModel {
  private let bag = DisposeBag()

  var networkManager: CarInfoManager!
  var tableDataSource = PublishRelay<[Announcements]>()
  var newtableDataSource = BehaviorRelay<[HomeTableItemsModel]>(value: [])
  let itemClicked = PublishSubject<HomeTableItemsModel>()

  var isLoading = ActivityIndicator()

  init(networkManager: CarInfoManager) {
    self.networkManager = networkManager
    getAnnouncement()
    itemClicked.asObservable()
      .subscribe { event in
        print(event)
        
      }
  }

//  func getAnnouncement() {
//    self.networkManager.getAnnouncements()
//    self.networkManager.announcements
//      //.trackActivity(isLoading) // Отслеживаем загрузку
//      .asObservable()  // Преобразуем Single в Observable
//      .bind(to: tableDataSource)
//      .disposed(by: bag)
//  }

  func getAnnouncement() {
      networkManager.getAnnouncements()
      networkManager.announcements
          .asObservable()
          .map { announcements in
              var items: [HomeTableItemsModel] = []
              items.append(.filter) // Add a filter item
            for announcement in announcements {
              items.append(.announcements(data: [announcement])) // Add each announcement as a separate item
            }
              return items
          }
          .bind(to: newtableDataSource)
          .disposed(by: bag)
  }

}
