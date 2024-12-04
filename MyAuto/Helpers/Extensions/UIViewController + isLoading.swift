//
//  UIViewController + isLoading.swift
//  MyAuto
//
//  Created by User on 20.11.24.
//


import RxSwift
import RxCocoa
import SVProgressHUD


//extension UIViewController {
//    func isLoading(for view: UIView) -> AnyObserver<Bool> {
//        return Binder(view, binding: { (hud, isLoading) in
//            switch isLoading {
//            case true:
//                SVProgressHUD.show()
//            case false:
//              SVProgressHUD.dismiss()
//                break
//            }
//        }).asObserver()
//    }
//}

extension UIViewController {
    func isLoading(for view: UIView) -> AnyObserver<Bool> {
        return Binder(view, binding: { (hud, isLoading) in
            DispatchQueue.main.async {
                if isLoading {
                    SVProgressHUD.show()  // Показываем индикатор
                } else {
                    SVProgressHUD.dismiss()  // Прячем индикатор
                }
            }
        }).asObserver()
    }
}


extension UIViewController {

    func presentAlert(withTitle title: String?, message : String,actionHandler: @escaping ()->()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            actionHandler()
        }
        alertController.addAction(OKAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if let popoverController = alertController.popoverPresentationController {
          popoverController.sourceView = self.view
          popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
          popoverController.permittedArrowDirections = []
        }
        self.present(alertController, animated: true, completion: nil)
    }

    func showAlert(title: String?, message: String?,handler:@escaping()->()?) {
        let alerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            handler()
        })
        alerController.addAction(cancelAction)
        if let popoverController = alerController.popoverPresentationController {
          popoverController.sourceView = self.view
          popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
          popoverController.permittedArrowDirections = []
        }
        DispatchQueue.main.async {
            self.present(alerController, animated: true, completion: nil)
        }
    }

    func showAlertwithTitle(title: String, message: String) {
        let alerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerController.addAction(cancelAction)
        if let popoverController = alerController.popoverPresentationController {
          popoverController.sourceView = self.view
          popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
          popoverController.permittedArrowDirections = []
        }
        DispatchQueue.main.async {
            self.present(alerController, animated: true, completion: nil)
        }
    }
}
