//
//  ResultErrorType.swift
//  MyAuto
//
//  Created by User on 04.11.24.
//

import Foundation

enum ResultErrorType: Error {
    case unknow
    case mailVerify
    case error(value: Error)
    case message(value: String)
}

extension ResultErrorType: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknow: return NSLocalizedString("Unknow error", comment: "")
        case .mailVerify: return NSLocalizedString("Please verify your email adress", comment: "")

        case .error(value: let value): return NSLocalizedString(value.localizedDescription, comment: "")
        case .message(value: let value): return NSLocalizedString(value, comment: "")
        }
    }
}
