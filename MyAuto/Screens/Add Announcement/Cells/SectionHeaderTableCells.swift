//
//  SectionHeaderTableCells.swift
//  MyAuto
//
//  Created by User on 08.04.24.
//

import UIKit

final class SettingsTableHeaderView: BaseView {
    
    // MARK: - UI
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .green
        return label
    }()
    
    // MARK: - LifeCycle
    override func configure() {
        super.configure()
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-6)
        }
    }
}
