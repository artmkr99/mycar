//
//  PhotoCarInfoCell.swift
//  MyAuto
//
//  Created by User on 17.05.24.
//

import UIKit

class PhotoCarInfoCell: BaseTableViewCell, UIScrollViewDelegate {
    
    private var selectedIndex: IndexPath?

    private let slideView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    private let carInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hyundai elantra 2017".uppercased()
        
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "10 800 $".uppercased()
        
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .systemRed
        sv.isPagingEnabled = true
        return sv
    }()
    
    private let ccontentView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemPurple
        return v
    }()
    
    private let imageViews: [UIImageView] = {
        var imageViews: [UIImageView] = []
        for x in 1...5 {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.image = UIImage(named: "elantraN")
            iv.backgroundColor = .blue
            iv.clipsToBounds = true
            imageViews.append(iv)
        }
        return imageViews
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoItemCollectionCell.self)
        
        return collectionView
    }()
    
    override func configure() {
        scrollView.delegate = self
        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupUI() {
        self.backgroundColor = .systemBlue
        
        self.contentView.addSubview(carInfoTitleLabel)
        carInfoTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(10)
        }
        
        self.contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(carInfoTitleLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(10)
        }
        
        self.contentView.addSubview(slideView)
        slideView.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(430)
        }
        
        slideView.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 30, left: 0, bottom: 60, right: 0))
        }
        
        for (index, imageView) in imageViews.enumerated() {
            scrollView.addSubview(imageView)
            imageView.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.width.equalTo(scrollView.snp.width)
                $0.height.equalTo(330)
                if index == 0 {
                    $0.leading.equalToSuperview()
                } else {
                    $0.leading.equalTo(imageViews[index - 1].snp.trailing)
                }
                if index == imageViews.count - 1 {
                    $0.trailing.equalToSuperview()
                }
            }
        }
        
        slideView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom).offset(0)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()

        }
    }
    
    private func updateSelectedIndex(_ indexPath: IndexPath) {
            if let previousIndex = selectedIndex {
                let previousCell = collectionView.cellForItem(at: previousIndex) as? PhotoItemCollectionCell
                previousCell?.setSelected(false)
            }
            
            selectedIndex = indexPath
            
            let currentCell = collectionView.cellForItem(at: indexPath) as? PhotoItemCollectionCell
            currentCell?.setSelected(true)
            
            collectionView.reloadData()
        }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
           updateSelectedIndex(IndexPath(item: pageIndex, section: 0))
       }
       
       func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
           if !decelerate {
               let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
               updateSelectedIndex(IndexPath(item: pageIndex, section: 0))
           }
       }
}

extension PhotoCarInfoCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(PhotoItemCollectionCell.self, indexPath: indexPath)
        cell.imageView.image = imageViews[indexPath.row].image
        cell.setSelected(indexPath == selectedIndex)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 5
        let spacingBetweenItems: CGFloat = 3 // Adjust as needed
        
        let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenItems
        let availableWidth = collectionView.frame.width - totalSpacing
        let cellWidth = availableWidth / numberOfItemsPerRow
        
        let cellHeight = collectionView.frame.height
        
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previousIndex = selectedIndex {
            let previousCell = collectionView.cellForItem(at: previousIndex) as? PhotoItemCollectionCell
            previousCell?.setSelected(false)
        }
        
        selectedIndex = indexPath
        
        let currentCell = collectionView.cellForItem(at: indexPath) as? PhotoItemCollectionCell
        currentCell?.setSelected(true)
        
        let selectedImageIndex = indexPath.row
        let offset = CGPoint(x: scrollView.frame.width * CGFloat(selectedImageIndex), y: 0)
        scrollView.setContentOffset(offset, animated: true)
        updateSelectedIndex(indexPath)  
    }
}
