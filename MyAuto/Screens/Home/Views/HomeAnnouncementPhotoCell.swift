//
//  HomeAnnouncementPhotoCell.swift
//  MyAuto
//
//  Created by User on 01.10.24.
//

import UIKit

final class HomeAnnouncementPhotoCell: BaseCollectionViewCell {
   let imageView: UIImageView = {
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

  func configure(with imagePath: String?) {
      if let imagePath = imagePath, let url = URL(string: imagePath) {
          imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "elantraN"))
      } else {
          imageView.image = UIImage(named: "elantraN")
      }
  }
}
