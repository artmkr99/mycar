//
//  SignUp.swift
//  MyAuto
//
//  Created by User on 28.10.24.
//

import Foundation

struct SignUpModel: Codable {
    let message: String
    let user: UserInfo
}

// MARK: - User
struct UserInfo: Codable {
    let password, role: String
    let id: Int
    let number, updatedAt, createdAt: String
}
