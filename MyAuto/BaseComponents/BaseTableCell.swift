//
//  BaseTableCell.swift
//  MyAuto
//
//  Created by User on 08.04.24.
//

import UIKit
import RxSwift
import RxRelay

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Constructor
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    // MARK: - LifeCycle
    func configure() {
        // selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bag = DisposeBag()
    }
}


class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    //
    func configure() {
    }
}
