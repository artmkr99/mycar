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
    var tableDataSource = BehaviorRelay<[SectionModel<FilterSection, FilterItem>]>(value: [])
    var tappedItem = PublishSubject<FilterItem>()

    init() {
        setupTableSections()
        handleItemSelection()
    }

    private func setupTableSections() {
        tableDataSource.accept([
            //.init(model: .regions, items: [.region("Приморский край"), .region("Владивосток")]),
            .init(model: .parameters, items: [
                .parameter("Марка, модель, year"),
                .parameter("пробег"),
                .parameter("цвет"),
                .parameter("обем двигт"),
                .parameter("обмен"),
                .parameter("регион"),

            ]),
            .init(model: .details, items: [
              .parameter("тип кузова"),
              .parameter("тип коробки"),
              .parameter("тип топлива"),
            ])
        ])
    }

    private func handleItemSelection() {
        tappedItem
            .subscribe(onNext: { item in
                switch item {
                case .region(let name):
                    print("Selected region: \(name)")
                case .parameter(let name):
                    print("Selected parameter: \(name)")

                }
            })
//            .disposed(by: DisposeBag())
    }
}

enum FilterSection {
    case regions
    case parameters
    case details
}

enum FilterItem {
    case region(String)
    case parameter(String)
}
