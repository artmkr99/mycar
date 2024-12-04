//
//  HomeAnnouncementView.swift
//  MyAuto
//
//  Created by User on 01.10.24.
//

import UIKit

final class HomeAnnouncementView: BaseView, UICollectionViewDelegateFlowLayout {
  private var imagesPath: [AnnouncementImage]?

  private let markModelLabel: UILabel = {
    let label = UILabel()
    label.text = "Hyundai elantra"
    return label
  }()

  private let priceLabel: UILabel = {
    let label = UILabel()
    label.text = "10000 $"
    label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    return label
  }()

  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 5
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .red
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(HomeAnnouncementPhotoCell.self)
    collectionView.showsHorizontalScrollIndicator = false

    return collectionView
  }()

  override func configure() {
    setupUI()
    collectionView.dataSource = self
    collectionView.delegate = self
  }

  func fillViewInfo(data: Announcements) {
    markModelLabel.text = "\(data.brandName) \(data.modelName)"
    priceLabel.text = data.price
    imagesPath = data.images
    collectionView.reloadData()
  }

  func setupUI() {
    addSubview(markModelLabel)
    markModelLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.left.equalToSuperview().offset(10)
    }

    addSubview(priceLabel)
    priceLabel.snp.makeConstraints {
      $0.top.equalTo(markModelLabel.snp.bottom).offset(10)
      $0.leading.equalTo(markModelLabel)
    }

    addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.top.equalTo(priceLabel.snp.bottom).offset(10)
      $0.left.equalToSuperview().offset(15)
      $0.right.equalToSuperview()
      $0.height.equalTo(200)

      $0.bottom.equalToSuperview().offset(-10)
    }
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let screenWidth = UIScreen.main.bounds.width
      let width = screenWidth / 1.4
      let height = collectionView.bounds.height

      return CGSize(width: width, height: height)
    }
}

extension HomeAnnouncementView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imagesPath?.count ?? 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(HomeAnnouncementPhotoCell.self, indexPath: indexPath)

    return cell
  }
}
