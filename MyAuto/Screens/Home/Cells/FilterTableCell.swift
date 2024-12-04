//
//  FilterTableCell.swift
//  MyAuto
//
//  Created by User on 27.10.24.
//

import UIKit

class FilterTableCell: BaseTableViewCell {

  private let holderStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.spacing = 1

    return stackView
  }()

  private let markModelFieldView: FieldView = {
    let view = FieldView()
    view.configureTitleText(text: "Mark Model")
    
    return view
  }()

  private let priceFieldView: FieldView = {
    let view = FieldView()
    view.configureTitleText(text: "Price")

    return view
  }()

  private let yearFieldView: FieldView = {
    let view = FieldView()
    view.configureTitleText(text: "Year")

    return view
  }()

  override func configure() {
    setupUI()
  }

  func setupUI() {
    self.selectionStyle = .none
//    holderStackView.backgroundColor = .blue
//    addSubview(holderStackView)
//    holderStackView.snp.makeConstraints {
//      $0.top.equalToSuperview().offset(20)
//      $0.left.equalToSuperview().offset(10)
//      $0.right.equalToSuperview().offset(-10)
//      $0.bottom.equalToSuperview().offset(-10)
//    }
//    holderStackView.addArrangedSubviews([markModelFieldView, priceFieldView, yearFieldView])
    addSubview(markModelFieldView)
    markModelFieldView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.left.equalToSuperview().offset(10)
      $0.right.equalToSuperview().offset(-10)
      $0.height.equalTo(30)
    }

    addSubview(priceFieldView)
    priceFieldView.snp.makeConstraints {
      $0.top.equalTo(markModelFieldView.snp.bottom).offset(3)
      $0.left.equalToSuperview().offset(10)
      $0.right.equalToSuperview().offset(-10)
      $0.height.equalTo(30)
    }

    addSubview(yearFieldView)
    yearFieldView.snp.makeConstraints {
      $0.top.equalTo(priceFieldView.snp.bottom).offset(3)
      $0.left.equalToSuperview().offset(10)
      $0.right.equalToSuperview().offset(-10)
      $0.bottom.equalToSuperview().offset(-10)
    }
  }
}
