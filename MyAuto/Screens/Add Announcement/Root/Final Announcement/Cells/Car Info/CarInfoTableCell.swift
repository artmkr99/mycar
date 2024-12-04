//
//  CarInfoTableCell.swift
//  MyAuto
//
//  Created by User on 27.05.24.
//

import UIKit

struct CarInfo {
    let engine: String
    let power: String
    let gearbox: String
    let drive: String
    let bodyType: String
    let color: String
    let mileage: String
    let steering: String
    let generation: String
    let configuration: String
}

class CarInfoTableCell: BaseTableViewCell {
    
    private let holderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    
    private let itemView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override func configure() {
        setupUI()
    }
    
    func setupUI() {
        contentView.addSubview(holderStackView)
        holderStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
//        holderStackView.addArrangedSubviews([
//            ItemView(name: "Engine", value: "2.0 Gasoline"),
//            ItemView(name: "Horse Powers", value: "129"),
//            ItemView(name: "Engine", value: "2.0 Gasoline"),
//            ItemView(name: "Engine", value: "2.0 Gasoline"),
//            ItemView(name: "Engine", value: "2.0 Gasoline"),
//            ItemView(name: "Engine", value: "2.0 Gasoline"),
//            ItemView(name: "Horse Powers", value: "129"),
//            ItemView(name: "Gear Box", value: "Automatic"),
//            ItemView(name: "Gear Box", value: "Automatic")])
      let carInfo = CarAnnouncementCollector.shared

         let fields: [(String, String?)] = [
             ("Brand", carInfo.carBrand),
             ("Model", carInfo.carModel),
             ("Year", carInfo.carYear),
             ("Mileage", carInfo.carMillage),
             ("Price", carInfo.carPrice),
             ("Color", carInfo.carColor),
             ("Body Type", carInfo.carBodyType),
             ("Gear Type", carInfo.carGearType),
             ("Fuel Type", carInfo.carFuelType),
             ("Is Changeable", carInfo.carIsChange),
             ("Engine Size", carInfo.carEngineSize)
         ]

         fields.forEach { name, value in
             if let value = value {
                 holderStackView.addArrangedSubview(ItemView(name: name, value: value))
             }
         }
    }
}


