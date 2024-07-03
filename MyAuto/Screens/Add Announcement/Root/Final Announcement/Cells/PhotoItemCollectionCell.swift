//
//  PhotoItemCollectionCell.swift
//  MyAuto
//
//  Created by User on 20.05.24.
//

import UIKit

class PhotoItemCollectionCell: BaseCollectionViewCell {
    
    private let holderContentView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    override func configure() {
        setupUI()
    }
    
    func setupUI() {
        addSubview(holderContentView)
        holderContentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.bottom.equalToSuperview().offset(-2)
        }
        holderContentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func setSelected(_ selected: Bool) {
        holderContentView.layer.borderColor = selected ? UIColor.red.cgColor : UIColor.clear.cgColor
    }
}

