//
//  CarMilageViewController.swift
//  MyAuto
//
//  Created by User on 23.04.24.
//

import Foundation
import UIKit

protocol CustomModalViewControllerDelegate: AnyObject {
    func didSaveData()
}

enum CarMilageData {
    case milage
    case price
    case engineSize
}

class CustomModalViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    weak var delegate: CustomModalViewControllerDelegate?
    var dataType = CarMilageData.milage

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        //view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 8
        
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("save".uppercased(), for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("close".uppercased(), for: .normal)
        button.backgroundColor = .black
        
        return button
    }()
    
    let defaultHeight: CGFloat = 250
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle

  init(data: CarMilageData) {
      self.dataType = data
      super.init(nibName: nil, bundle: nil)
  }


  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        registerForKeyboardNotifications()
        setupTapGesture()
        textField.delegate = self
        closeButton.addTarget(self, action: #selector(tappedCloseButton), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.textField.becomeFirstResponder()
    }
        
    deinit {
        unregisterForKeyboardNotifications()
    }
    
    // MARK: - Setup
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        dimmedView.addGestureRecognizer(tapGesture)
        dimmedView.isUserInteractionEnabled = true
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func tappedSaveButton() {
      switch dataType {
      case .milage:
        CarAnnouncementCollector.shared.carMillage = self.textField.text
        AnnouncementDataCollectorManager.shared.milage = self.textField.text
      case .price:
        CarAnnouncementCollector.shared.carPrice = self.textField.text
        AnnouncementDataCollectorManager.shared.price = self.textField.text

      case .engineSize:
        CarAnnouncementCollector.shared.carEngineSize = self.textField.text
        AnnouncementDataCollectorManager.shared.engineSize = self.textField.text
      }
        delegate?.didSaveData()
        self.dismiss(animated: true)
    }
    
    @objc func tappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupConstraints() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
        containerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 150),
            textField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        containerView.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
        
        containerView.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(10)
        }
    }
    
    // MARK: - Keyboard Handling
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let keyboardHeight = keyboardFrame.height
        containerViewBottomConstraint?.constant = -keyboardHeight
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        containerViewBottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
