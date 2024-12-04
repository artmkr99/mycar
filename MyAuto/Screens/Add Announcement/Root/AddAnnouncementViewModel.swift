//
//  AddAnnouncementViewModel.swift
//  MyAuto
//
//  Created by User on 08.04.24.
//

import RxDataSources
import RxCocoa
import RxSwift

class AddAnnouncementViewModel {
    
    private let coordinator: AddAnnouncementCoordinator
    var tableDataSource = BehaviorRelay<[SectionModel<AddAnnouncementTableSection, AddAnnouncementTableItems>]>(value: [])
    var tappedToTableItem = PublishSubject<AddAnnouncementTableItems>()
    
    init(coordinator: AddAnnouncementCoordinator) {
        self.coordinator = coordinator
        setupTableCells()
        setupCellSelection()
    }
    
    func setupTableCells() {
        tableDataSource.accept([
            .init(model: .autoInfo, items: [
                .carMark,
                .carModel,
                .carYear
            ]),
            .init(model: .anotherInfo, items: [
                .carMilage,
                .carColor,
                .carBodyType,
                .carEngineSize,
                .carGearType,
                .carFuelType
            ]),
            .init(model: .isChangeBlock, items: [
                .isChange,
                .carPrice,
                .region,
                .carPhotos
            ])
        ])
    }
    
    func setupCellSelection() {
        tappedToTableItem.asObservable()
            .subscribe(onNext: { [unowned self] item in
                switch item {
                case .carMark:
                    self.coordinator.router.onNext(.carMark)
                case .carModel:
                    self.coordinator.router.onNext(.carModel)
                case .carYear:
                    self.coordinator.router.onNext(.carYearSelection)
                case .carMilage:
                    self.coordinator.router.onNext(.halfView)
                case .carColor:
                    self.coordinator.router.onNext(.carColor)
                case .carBodyType:
                    self.coordinator.router.onNext(.carBodyType)
                case .carEngineSize:
                    self.coordinator.router.onNext(.carEngineSize)
                case .carGearType:
                    self.coordinator.router.onNext(.carGearType)
                case .carFuelType:
                    self.coordinator.router.onNext(.carFuelType)
                case .isChange:
                    self.coordinator.router.onNext(.isChange)
                case .carPhotos:
                    self.coordinator.router.onNext(.carPhotos)
                case .carPrice:
                  self.coordinator.router.onNext(.carPrice)
                case .region:
                  self.coordinator.router.onNext(.region)
                }
            })
    }
    
}
