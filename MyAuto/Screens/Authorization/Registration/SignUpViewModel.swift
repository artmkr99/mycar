//
//  SignUpViewModel.swift
//  MyAuto
//
//  Created by User on 04.11.24.
//

import RxSwift
import RxRelay

class SignUpViewModel {
    private let userAccountManager: UserAccountManagerType
    private var coordinator: AuthorizationCoordinator
    private let bag = DisposeBag()

    var signUpTrigger = PublishRelay<Void>()
    var alreadyHasAccountTrigger = PublishRelay<Void>()

    var userNumber = BehaviorRelay<String?>(value: nil)
    var userPassword = BehaviorRelay<String?>(value: nil)

    init(accountManager: UserAccountManagerType, coordinator: AuthorizationCoordinator) {
      self.userAccountManager = accountManager
      self.coordinator = coordinator

      signUpTrigger.asObservable()
          .flatMapLatest { [unowned self] _ -> Observable<Result<Void, ResultErrorType>> in
              let number = self.userNumber.value ?? ""
              let password = self.userPassword.value ?? ""

            return self.userAccountManager.input.register(with: number, password: password)
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
