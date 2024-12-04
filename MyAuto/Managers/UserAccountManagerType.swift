//
//  UserAccauntManagerType.swift
//  MyAuto
//
//  Created by User on 04.11.24.
//

import Foundation

import Foundation
import RxSwift

protocol UserAccountManagerInput {
//    var userID: String? { get set }
//    var userEmail: String? { get set }
      var authToken: String? { get set }
//    var isLoggedUser: Bool { get set }
//    var refreshToken: String? { get set }
//
//    var lastName: String? { get set }
//    var firstName: String? { get set }
//    var hasActiveChat: Bool? { get set }

    func login(number: String, password: String) -> Observable<Result<Void, ResultErrorType>>
    func register(with number: String, password: String) -> Observable<Result<Void, ResultErrorType>>
}

protocol UserAccountManagerOutput {

}

protocol UserAccountManagerType {
    var input: UserAccountManagerInput { set get }
    var output: UserAccountManagerOutput { get }
}

extension UserAccountManagerType where Self: UserAccountManagerInput & UserAccountManagerOutput {
    var input: UserAccountManagerInput {
        set {}
        get { return self }
    }
    var output: UserAccountManagerOutput { return self }
}
