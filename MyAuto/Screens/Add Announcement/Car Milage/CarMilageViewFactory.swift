//
//  CarMilageViewFactory.swift
//  MyAuto
//
//  Created by User on 02.07.24.
//

import Foundation

enum CarMilageViewFactory {
  static func create(type: CarMilageData) -> CustomModalViewController {
    let controller = CustomModalViewController(data: type)

    return controller
  }
}
