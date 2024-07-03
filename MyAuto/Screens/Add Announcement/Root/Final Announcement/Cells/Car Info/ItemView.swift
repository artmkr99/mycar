//
//  ItemView.swift
//  MyAuto
//
//  Created by User on 03.06.24.
//

import UIKit

class ItemView: UIView {
    
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
    
    init(name: String, value: String) {
        super.init(frame: .zero)  // Use .zero or another appropriate frame
        self.backgroundColor = .white
        self.cellName.text = name
        self.cellValue.text = value
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(cellName)
        cellName.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        addSubview(cellValue)
        cellValue.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
        }
    }

}
