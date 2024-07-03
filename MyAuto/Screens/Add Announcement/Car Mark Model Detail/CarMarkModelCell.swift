//
//  CarMarkModelCell.swift
//  MyAuto
//
//  Created by User on 19.04.24.
//

import UIKit

class CarMarkModelCell: BaseTableViewCell {
     let markLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override func configure() {
        setupUI()
    }
    
    func fill(data: Brand) {
        markLabel.text = data.name
    }
    
    func setupUI() {
        addSubview(markLabel)
        markLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
        }
    }
}
