//
//  CarColorTableCell.swift
//  MyAuto
//
//  Created by User on 29.04.24.
//

import UIKit

class CarColorTableCell: BaseTableViewCell {
    private let colorImageView: UIView = {
        let imageView = UIView()
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray.cgColor
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override func configure() {
        setupUI()
    }
    
    func fill(color:UIColor, name: String) {
        colorImageView.backgroundColor = color
        titleLabel.text = name
    }
    
    func setupUI() {
        addSubview(colorImageView)
        colorImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
            $0.centerY.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(colorImageView.snp.right).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
}
