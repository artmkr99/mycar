//
//  CarPhotoButtonTableCell.swift
//  MyAuto
//
//  Created by User on 17.05.24.
//

import UIKit

class CarPhotoButtonTableCell: BaseTableViewCell {
    private let photoButton: UIButton = {
        let button = UIButton()
        button.setTitle("add photo".uppercased(), for: .normal)
        button.backgroundColor = .blue
        
        return button
    }()
    
    override func configure() {
        setupUI()
    }
    
    func setupUI(){
        addSubview(photoButton)
        photoButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-30)
        }
    }
}
