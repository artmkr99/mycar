//
//  ImagePickerManager.swift
//  MyAuto
//
//  Created by User on 01.09.24.
//

import UIKit
import PhotosUI

class ImagePickerManager: NSObject, PHPickerViewControllerDelegate {

    private var viewController: UIViewController?
    private var completion: (([UIImage]) -> Void)?

    func presentImagePicker(from viewController: UIViewController, maxSelection: Int = 5, completion: @escaping ([UIImage]) -> Void) {
        self.viewController = viewController
        self.completion = completion

        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = maxSelection // Максимальное количество изображений
        configuration.filter = .images // Только изображения

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        viewController.present(picker, animated: true, completion: nil)
    }

    // MARK: - PHPickerViewControllerDelegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        guard !results.isEmpty else {
            completion?([])
            return
        }

        var images: [UIImage] = []
        let dispatchGroup = DispatchGroup()

        for result in results {
            dispatchGroup.enter()
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                    if let image = object as? UIImage {
                        images.append(image)
                    }
                    dispatchGroup.leave()
                }
            } else {
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.completion?(images)
        }
    }
}
