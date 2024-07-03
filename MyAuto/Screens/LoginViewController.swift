//
//  ViewController.swift
//  MyAuto
//
//  Created by User on 27.03.24.
//

import UIKit

class LoginViewController: UIViewController {
    
    let networkService = NetworkService()
    
    private let loginTextField: BaseTextFieldView = {
        let textField = BaseTextFieldView()
        textField.baseTextField.text = "t@mail.ru"
        
        return textField
    }()
    
    private let passwordTextField: BaseTextFieldView = {
        let textField = BaseTextFieldView()
        textField.baseTextField.text = "111111"

        return textField
    }()
    
    private let signInButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("sign in".uppercased(), for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        signInButton.addTarget(self, action: #selector(tappedSignInButton), for: .touchUpInside)
        setupUI()
    }
}

extension LoginViewController {
    func setupUI() {
        self.view.addSubview(loginTextField)
        loginTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
        
        self.view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(loginTextField.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
        
        self.view.addSubview(signInButton)
        signInButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
    }
}

extension LoginViewController {
    @objc func tappedSignInButton() {
        guard let loginText = loginTextField.baseTextField.text else { return }
        guard let passwordText = passwordTextField.baseTextField.text else { return }

        networkService.login(email: loginText, password: passwordText) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    let vc = MainTabBarViewController()
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
