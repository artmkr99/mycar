//
//  LoginViewModel.swift
//  MyAuto
//
//  Created by User on 04.11.24.
//

import RxSwift
import RxRelay

class LoginViewModel {
    private let userAccountManager: UserAccountManagerType
    private var coordinator: AuthorizationCoordinator
    private let bag = DisposeBag()

    var signInTrigger = PublishRelay<Void>()
    var dontHaveAccountTrigger = PublishRelay<Void>()

    var userNumber = BehaviorRelay<String?>(value: nil)
    var userPassword = BehaviorRelay<String?>(value: nil)

    init(accountManager: UserAccountManagerType, coordinator: AuthorizationCoordinator) {
      self.userAccountManager = accountManager
      self.coordinator = coordinator

      dontHaveAccountTrigger.asObservable()
          .map { AuthorizationRoute.signup }
          .bind(to: coordinator.router)
          .disposed(by: bag)

      signInTrigger.asObservable()
          .flatMapLatest { [unowned self] _ -> Observable<Result<Void, ResultErrorType>> in
              let number = self.userNumber.value ?? ""
              let password = self.userPassword.value ?? ""

            return self.userAccountManager.input.login(number: number, password: password)
          }
          .subscribe(onNext: { [weak self] response in
              switch response {
              case .success:
                self?.coordinator.router.onNext(.home)
              case .failure(let message):
                print(message)
                  //self?.alertMessage.onNext(message.localizedDescription)
              }
          }).disposed(by: bag)
    }
}
