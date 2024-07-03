//
//  BaseButtonVIew.swift
//  MyAuto
//
//  Created by User on 01.04.24.
//

import UIKit

class BaseButton: UIButton {
    
    // MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    func configure() {
        self.backgroundColor = .orange
        // Default height
        self.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}
