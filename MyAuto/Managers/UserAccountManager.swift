//
//  UserAccauntManager.swift
//  MyAuto
//
//  Created by User on 04.11.24.
//

import RxSwift
import Foundation

final class UserAccountManager: UserAccountManagerType {
  private let network: AuthNetworkProviderType

  var authToken: String? {
      set {
          UserDefaults.standard.set(newValue, forKey: UserKeys.kAuthToken)
          UserDefaults.standard.synchronize()
          print("Сохраняем токен: \(newValue ?? "nil")")
      }
      get {
          let token = UserDefaults.standard.string(forKey: UserKeys.kAuthToken)
          print("Получаем токен: \(token ?? "nil")")
          return token
      }
  }

  init(network: AuthNetworkProviderType) {
      self.network = network
  }
}

extension UserAccountManager: UserAccountManagerInput, UserAccountManagerOutput {  

  func login(number: String, password: String) -> RxSwift.Observable<Result<Void, ResultErrorType>> {
    return network.signIn(login: number, password: password)
      .asObservable()
      .flatMapLatest { [weak self] response -> Observable<Result<Void, ResultErrorType>> in
          guard let `self` = self else { return .just(.failure(.unknow)) }
        print(response)
          guard let error = response.fields else {
                let accessToken = response.token
//                print(response)
//                print(accessToken)
//                self.authToken = "Bearer \(accessToken)"
//                let savedToken = UserDefaults.standard.string(forKey: UserKeys.kAuthToken)
                UserDefaults.standard.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAsIm51bWJlciI6IiszNzQ5OTc3Nzc3NyIsImlhdCI6MTczMTQwMDA1NSwiZXhwIjoxNzYyOTM2MDU1fQ.bBB91YFeXyP02NzcoOY0vbXNeISD53JXsyzBGDm4v6w", forKey: UserKeys.kAuthToken)
               // print("Verified saved token immediately: \(savedToken ?? "nil")")

              return .just(.success(()))
          }

        return .just(.failure(.message(value: response.message ?? error.number)))
      }
  }
  
  func register(with number: String, password: String) -> RxSwift.Observable<Result<Void, ResultErrorType>> {
    return network.signUp(login: number, password: password)
      .asObservable()
      .flatMapLatest { [weak self] response -> Observable<Result<Void, ResultErrorType>> in
        guard let `self` = self else { return .just(.failure(.unknow)) }
        print(response)
        return .just(.success(()))

      }
  }
  
}
//return network.passwordRecovery(email: email)
//    .asObservable()
//    .flatMapLatest { response -> Observable<Result<String, ResultErrorType>> in
//        guard response.res == nil  else { return .just(.failure(.unknow)) }
//        return .just(.success(response.comments ?? "Password Recowered"))
//    }
