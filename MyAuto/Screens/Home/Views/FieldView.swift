//
//  FieldView.swift
//  MyAuto
//
//  Created by User on 27.10.24.
//

import UIKit
import RswiftResources

class FieldView: BaseView {

  private let holderView: UIView = {
    let view = UIView()
    return view
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()

    return label
  }()

  override func configure() {
    setupUI()
  }

  func setupUI() {
    addSubview(holderView)
    holderView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    holderView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.left.equalToSuperview().offset(10)
    }
  }

  func configureTitleText(text: String) {
    titleLabel.text = text
    holderView.backgroundColor = R.color.brand_gray()
  }
}
