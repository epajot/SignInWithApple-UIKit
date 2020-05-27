//
//  UserCredentials.swift
//  Juice
//
//  Created by Rudolf Farkas on 27.05.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import AuthenticationServices
import Foundation

struct UserCredential: Codable, Equatable {
    let id: String
    let fullName: String
    let email: String

    init(id: String = "", fullName: String = "", email: String = "") {
        self.id = id
        self.fullName = fullName
        self.email = email
    }

    init(credential: ASAuthorizationAppleIDCredential) {
        id = credential.user
        if let givenName = credential.fullName?.givenName,
            let familyName = credential.fullName?.familyName {
            fullName = "\(givenName) \(familyName)"
        } else {
            fullName = ""
        }
        email = credential.email ?? ""
    }

    static let keychainAccount = "userCredentials"
}
