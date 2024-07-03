//
//  UIStackVIew.swift
//  MyAuto
//
//  Created by User on 03.06.24.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
