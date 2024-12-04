//
//  ViewController.swift
//  MyAuto
//
//  Created by User on 27.03.24.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class LoginViewController: UIViewController {

    var viewModel: LoginViewModel!

    private let loginTextField: BaseTextFieldView = {
      let textField = BaseTextFieldView()
      textField.baseTextField.text = "+37499992130"

      return textField
    }()

    private let passwordTextField: BaseTextFieldView = {
      let textField = BaseTextFieldView()
      textField.baseTextField.text = "123456789"

      return textField
    }()

    private let signInButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("sign in".uppercased(), for: .normal)


        return button
    }()

    private let dontHaveAccount: UIButton = {
      let button = UIButton()
      button.setTitle("Dont have account sign up", for: .normal)
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
        signInButton.rx.tap
            .bind(to: viewModel.signInTrigger)
            .disposed(by: bag)

        dontHaveAccount.rx.tap
            .bind(to: viewModel.dontHaveAccountTrigger)
            .disposed(by: bag)

        (loginTextField.baseTextField.rx.text <-> viewModel.userNumber).disposed(by: bag)
        (passwordTextField.baseTextField.rx.text <-> viewModel.userPassword).disposed(by: bag)
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

          self.view.addSubview(dontHaveAccount)
          dontHaveAccount.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
          }

          self.view.addSubview(signInButton)
          signInButton.snp.makeConstraints {
              $0.top.equalTo(dontHaveAccount.snp.bottom).offset(20)
              $0.left.equalToSuperview().offset(10)
              $0.right.equalToSuperview().offset(-10)
          }
      }
  }

extension LoginViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
