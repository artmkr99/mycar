//
//  SignUpViewController.swift
//  MyAuto
//
//  Created by User on 04.11.24.
//

import UIKit

class SignUpViewController: UIViewController {

  var viewModel: SignUpViewModel!

  private let loginTextField: BaseTextFieldView = {
    let textField = BaseTextFieldView()

    return textField
  }()

  private let passwordTextField: BaseTextFieldView = {
    let textField = BaseTextFieldView()
   

    return textField
  }()

  private let registrationButton: BaseButton = {
      let button = BaseButton()
      button.setTitle("Registration".uppercased(), for: .normal)

      return button
  }()

  private let goToSignIn: UIButton = {
    let button = UIButton()
    button.setTitle("Already have account", for: .normal)
    button.titleLabel?.textColor = .black
    button.backgroundColor = .orange

    return button
  }()

  override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .white
      setupUI()
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
      view.addGestureRecognizer(tapGesture)
      bindRx()
  }

  func bindRx() {
      registrationButton.rx.tap
      .bind(to: viewModel.signUpTrigger)
          .disposed(by: bag)

      goToSignIn.rx.tap
        .bind(to: viewModel.alreadyHasAccountTrigger)
        .disposed(by: bag)

      (loginTextField.baseTextField.rx.text <-> viewModel.userNumber).disposed(by: bag)
      (passwordTextField.baseTextField.rx.text <-> viewModel.userPassword).disposed(by: bag)
  }
}

extension SignUpViewController {
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

        self.view.addSubview(goToSignIn)
        goToSignIn.snp.makeConstraints {
          $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
          $0.centerX.equalToSuperview()
        }

        self.view.addSubview(registrationButton)
        registrationButton.snp.makeConstraints {
            $0.top.equalTo(goToSignIn.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
    }
}

extension SignUpViewController {
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
