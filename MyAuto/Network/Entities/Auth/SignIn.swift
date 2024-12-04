//
//  SignIn.swift
//  MyAuto
//
//  Created by User on 28.10.24.
//


struct SignInModel: Codable {
  let message, token: String
  let fields: Fields?
}

// MARK: - Fields
struct Fields: Codable {
    let number, password: String
}
