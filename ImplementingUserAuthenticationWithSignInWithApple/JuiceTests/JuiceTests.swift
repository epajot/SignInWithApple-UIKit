//
//  JuiceTests.swift
//  JuiceTests
//
//  Created by Rudolf Farkas on 26.05.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Juice
import XCTest

class JuiceTests: XCTestCase {
    let testAccountKey = "testUserCredentials"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        do {
            try KeychainItem(account: testAccountKey).deleteItem()
        } catch {
            XCTFail("deleteItem failed")
        }
    }

    func test_KeychainItem() {
        let userId = KeychainItem.currentUserIdentifier
        XCTAssertEqual(userId, "000177.cbd4407ecc7244a0bf6d3b4d8cd83569.1750")

        do {
            let userId2: String = try KeychainItem(account: "userIdentifier").readItem()
            XCTAssertEqual(userId2, "000177.cbd4407ecc7244a0bf6d3b4d8cd83569.1750")
        } catch {
            XCTFail("")
        }
    }

    func test_KeychainItem2() {
        do {
            try KeychainItem(account: testAccountKey).deleteItem()
        } catch {
            XCTFail("deleteItem failed")
        }

        let userCredentials: String? = try? KeychainItem(account: testAccountKey).readItem()
        XCTAssertNil(userCredentials)

        do {
            try KeychainItem(account: testAccountKey).saveItem("TEST_CRED")
        } catch {
            XCTFail("saveItem failed")
        }

        let userCredentials2: String? = try? KeychainItem(account: testAccountKey).readItem()
        XCTAssertEqual(userCredentials2, "TEST_CRED")
    }

    func test_KeychainItem3() {
        struct UserCredentials: Codable, Equatable {
            let appleId = "TEST_ID"
            let fullName = "N.N."
            let emnail = "x@y.z"
        }

        let uCred = UserCredentials()

        do {
            try KeychainItem(account: testAccountKey).deleteItem()
        } catch {
            XCTFail("deleteItem failed")
        }

        let userCredentials: UserCredentials? = try? KeychainItem(account: testAccountKey).readItem()
        XCTAssertNil(userCredentials)

        do {
            try KeychainItem(account: testAccountKey).saveItem(uCred)
        } catch {
            XCTFail("saveItem failed")
        }

        let userCredentials2: UserCredentials? = try? KeychainItem(account: testAccountKey).readItem()
        XCTAssertEqual(userCredentials2, uCred)
    }
}
