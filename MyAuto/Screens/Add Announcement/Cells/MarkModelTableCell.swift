//
//  MarkModelTableCell.swift
//  MyAuto
//
//  Created by User on 08.04.24.
//

import UIKit

class MarkModelTableCell: BaseTableViewCell {
    
     let cellName: UILabel = {
        let label = UILabel()
        label.text = "cellName"
        return label
    }()
    
     let cellValue: UILabel = {
        let label = UILabel()
        label.text = "cellValue"

        return label
    }()

    override func configure() {
        setupUI()
    }
    
    
    func setupUI() {
        addSubview(cellName)
        cellName.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
        }
        addSubview(cellValue)
        cellValue.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
        }
    }

}
