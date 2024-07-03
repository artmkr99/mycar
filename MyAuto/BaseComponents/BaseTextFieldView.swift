//
//  BaseTextFieldView.swift
//  MyAuto
//
//  Created by User on 01.04.24.
//

import UIKit

final class BaseTextFieldView: BaseView {

     let baseTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .gray
        
        return textField
    }()
    
    override func configure() {
        setupUI()
    }
    
    func setupUI() {
        addSubview(baseTextField)
        baseTextField.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(50)
        }
    }

}

