//
//  HomeAnnouncementPhotoCell.swift
//  MyAuto
//
//  Created by User on 01.10.24.
//

import UIKit

final class HomeAnnouncementPhotoCell: BaseCollectionViewCell {
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "elantraN")
    imageView.contentMode = .scaleToFill

    return imageView
  }()

  override func configure() {
    addSubview(imageView)
    imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
