//
//  UICollectionView.swift
//  MyAuto
//
//  Created by User on 20.05.24.
//


import UIKit

extension UICollectionViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func registerHeaderClass<T: UICollectionReusableView>(_: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: T.self))
    }
    
    func registerNib<T: UICollectionViewCell>(_:T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func registerHeader<T: UICollectionReusableView>(_: T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forSupplementaryViewOfKind:
                    UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: T.self))
    }
    
    func dequeue<T: UICollectionViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        let cellIdentifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? T else {
            fatalError("Failed to cast cell \(cellIdentifier) to desired type")
        }
        return cell
    }
    
    func dequeueHeader<T: UICollectionReusableView>(_: T.Type, viewForSupplementaryElementOfKind kind: String, indexPath: IndexPath) -> T {
        let cellIdentifier = String(describing: T.self)
        guard let header = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:
                                                                cellIdentifier, for: indexPath) as? T else {
            fatalError("Failed to cast cell \(cellIdentifier) to desired type")
        }
        return header
    }
}

