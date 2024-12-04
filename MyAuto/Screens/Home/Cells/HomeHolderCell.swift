//
//  HomeHolderCell.swift
//  MyAuto
//
//  Created by User on 01.10.24.
//

import UIKit

class HomeHolderCell: BaseTableViewCell {
  private let baseView: UIView = {
    let view = UIView()
    view.backgroundColor = .orange

    return view
  }()

  private let announcementView: HomeAnnouncementView = {
    let view = HomeAnnouncementView()

    return view
  }()

  override func configure() {
    setupUI()
  }

  func fill(data: Announcements) {
    announcementView.fillViewInfo(data: data)
  }

  func setupUI() {
    contentView.addSubview(baseView)
    baseView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.left.equalToSuperview().offset(3)
      $0.right.equalToSuperview().offset(-3)
      $0.bottom.equalToSuperview().offset(-10)
    }

    baseView.addSubview(announcementView)
    announcementView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.left.equalToSuperview()
      $0.right.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }
}
