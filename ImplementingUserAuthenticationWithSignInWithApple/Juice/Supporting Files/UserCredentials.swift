//
//  UserCredentials.swift
//  Juice
//
//  Created by Rudolf Farkas on 27.05.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct UserCredentials: Codable, Equatable {
    let appleId: String
    let fullName: String
    let email: String
}
