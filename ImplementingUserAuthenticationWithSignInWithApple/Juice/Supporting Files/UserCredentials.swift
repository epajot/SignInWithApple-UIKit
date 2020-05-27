//
//  UserCredentials.swift
//  Juice
//
//  Created by Rudolf Farkas on 27.05.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct UserCredentials: Codable, Equatable {
    let id: String
    let fullName: String
    let email: String

    init(id: String = "", fullName: String = "", email: String = "") {
        self.id = id
        self.fullName = fullName
        self.email = email
    }

    static let keychainAccount = "userCredentials"
}
