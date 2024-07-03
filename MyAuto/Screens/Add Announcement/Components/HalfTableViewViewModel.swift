//
//  HalfTableViewViewModel.swift
//  MyAuto
//
//  Created by User on 03.05.24.
//

import Foundation
import RxSwift

class HalfTableViewViewModel {
    let tableDataSource = BehaviorSubject<[String]>(value: [])
    var type: HalfTableViewType!
    
    init(type: HalfTableViewType) {
        self.type = type

        switch type {
        case .gearType:
            tableDataSource.onNext(["peredok", "zadok", "polni"])
        case .fuelType:
            tableDataSource.onNext(["benzin", "disel", "electric"])
        case .bodyType:
            tableDataSource.onNext(["Կուպե", "Սեդան", "Հեծբեկ"])
        case .changeType:
            tableDataSource.onNext(["hamarjeq", "aveli tang", "aveli ejan"])
        }
        
    }

}
