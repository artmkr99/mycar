//
//  TabBarTypeEnum.swift
//  MyAuto
//
//  Created by User on 03.10.24.
//

import Foundation
import UIKit

enum TabBarTypesEnum: Int {
    case home = 0
    case addAnnouncement

    var title: String {
        switch self {
        case .home: return "Home"
        case .addAnnouncement: return "Announcement"
        }
    }

    var selectIcon: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill") // System icon for selected home
        case .addAnnouncement:
            return UIImage(systemName: "plus.circle.fill") // System icon for selected add announcement
        }
    }

    var unselectIcon: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house") // System icon for unselected home
        case .addAnnouncement:
            return UIImage(systemName: "plus.circle") // System icon for unselected add announcement
        }
    }
}

