//
//  FilterViewModel.swift
//  MyAuto
//
//  Created by User on 28.11.24.
//

import RxDataSources
import RxCocoa
import RxSwift

class FilterViewModel {
  private let coordinator: FilterCoordinator
  private let disposeBag = DisposeBag()

  var tableDataSource = BehaviorRelay<[SectionModel<FilterSection, FilterItem>]>(value: [])
  var tappedItem = PublishSubject<FilterItem>()

  init(coordinator: FilterCoordinator) {
    self.coordinator = coordinator
    setupTableSections()
    handleItemSelection()
  }


  private func setupTableSections() {
    tableDataSource.accept([
      .init(model: .details, items: [
        .makeModelYear,
        .mileage,
        .color,
        .engineVolume,
        .exchange,
        .region,
      ]),
      .init(model: .details, items: [
        .bodyType,
        .gearboxType,
        .fuelType,
      ])
    ])
  }

  private func handleItemSelection() {
    tappedItem
      .subscribe(onNext: { [weak self] item in
        guard let coordinator = self?.coordinator else { return }
        switch item {
        case .makeModelYear:
          coordinator.router.onNext(.carMarkModelYear)
        case .mileage:
          coordinator.router.onNext(.mileage)
        case .color:
          coordinator.router.onNext(.color)
        case .engineVolume:
          coordinator.router.onNext(.engineSize)
        case .exchange:
          coordinator.router.onNext(.exchange)
        case .region:
          coordinator.router.onNext(.region)
        case .bodyType:
          coordinator.router.onNext(.bodyType)
        case .gearboxType:
          coordinator.router.onNext(.gearBoxType)
        case .fuelType:
          coordinator.router.onNext(.fuelType)
        case .price:
          coordinator.router.onNext(.fuelType)
        }
      })
      .disposed(by: disposeBag)
  }
}

enum FilterSection {
  case regions
  case parameters
  case details
}

enum FilterItem {
    case makeModelYear
    case mileage
    case color
    case engineVolume
    case exchange
    case price
    case region
    case bodyType
    case gearboxType
    case fuelType

    var title: String {
      switch self {
      case .makeModelYear: return "Марка, модель, year"
      case .mileage: return "Пробег"
      case .color: return "Цвет"
      case .engineVolume: return "Объем двигателя"
      case .exchange: return "Обмен"
      case .price: return "Цена"
      case .region: return "Регион"
      case .bodyType: return "Тип кузова"
      case .gearboxType: return "Тип коробки"
      case .fuelType: return "Тип топлива"
      }
    }
}
