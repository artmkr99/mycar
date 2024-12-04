//
//  HalfTableViewViewModel.swift
//  MyAuto
//
//  Created by User on 03.05.24.
//

import Foundation
import RxSwift

class HalfTableViewViewModel {

  private let networkService: CarInfoManager

  let tableDataSource = BehaviorSubject<[String]>(value: [])
  let selectedItem = PublishSubject<String>()
  let reloadTable = PublishSubject<Void>()
  var type: HalfTableViewType!

  private var bag = DisposeBag()

  init(type: HalfTableViewType, networkService: CarInfoManager) {
    self.type = type
    self.networkService = networkService

    switch type {
    case .gearType:
      var items = [String]()
      networkService.getCarGearType()
      networkService.gearTypes
        .subscribe(onNext: { bodyTypes in
          bodyTypes.forEach { item in

            items.append(item.type)
          }
          self.tableDataSource.onNext(items)
        })
        .disposed(by: bag)
    case .fuelType:
      var items = [String]()
      networkService.getCarFuelType()
      networkService.fuelTypes
        .subscribe(onNext: { bodyTypes in
          bodyTypes.forEach { item in

            items.append(item.type)
          }
          self.tableDataSource.onNext(items)
        })
        .disposed(by: bag)
    case .bodyType:
      var items = [String]()
      networkService.getCarBodyTypes()
      networkService.bodyTypes
        .subscribe(onNext: { bodyTypes in
          bodyTypes.forEach { item in

            items.append(item.type)
          }
          self.tableDataSource.onNext(items)
        })
        .disposed(by: bag)
    case .changeType:
      var items = [String]()
      networkService.getCarChangeType()
      networkService.changeTypes
        .subscribe(onNext: { bodyTypes in
          bodyTypes.forEach { item in
            
            items.append(item.type)
          }
          self.tableDataSource.onNext(items)
        })
        .disposed(by: bag)
    }

    selectedItem
      .subscribe(onNext: { [weak self] value in
        guard let self = self else { return }

        var data = CarAnnouncementCollector.shared

        switch type {
        case .gearType:
          data.carGearType = value
         // AnnouncementDataCollectorManager.shared.gearType = value
        case .fuelType:
          data.carFuelType = value
          //AnnouncementDataCollectorManager.shared.fuelType = value
        case .bodyType:
          data.carBodyType = value
          //AnnouncementDataCollectorManager.shared.bodyType = value
        case .changeType:
          data.carIsChange = value
          //AnnouncementDataCollectorManager.shared.isChange = value
        }
        self.reloadTable.onNext(())
        print(data)
      })
      .disposed(by: bag)

  }

}
