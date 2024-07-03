//
//  BaseNavigationController.swift
//  MyAuto
//
//  Created by User on 08.04.24.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set custom view with logo
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        customView.backgroundColor = .red
        self.navigationItem.titleView = customView
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//         super.viewWillDisappear(animated)
//         // Освободите ресурсы перед выходом из контроллера
//         self.navigationItem.titleView = nil
//         // Очистите backgroundImageView
//         for subview in self.view.subviews {
//             if let imageView = subview as? UIImageView {
//                 imageView.image = nil
//                 imageView.removeFromSuperview()
//             }
//         }
//     }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// Method that insert a logo image to the titleView
    func setLogoImage() {
//        let logoImageView = UIImageView(image: R.image.appTitle()!)
//        logoImageView.contentMode = .scaleAspectFit
//        self.navigationItem.titleView = logoImageView
    }
}
