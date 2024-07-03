//
//  BaseView.swift
//  MyAuto
//
//  Created by User on 01.04.24.
//

import UIKit

class BaseView: UIView {
    
    // MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    // MAKR: -
    func configure() {
        
    }
    
}
