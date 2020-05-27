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
        let uCred = UserCredentials(id: "TEST_ID", fullName: "N.N.", email: "x@y.z")

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

    func test_KeychainItem4() {
       // ---- LoginViewController.authorizationController(controller:didCompleteWithAuthorization:) userIdentifier: 000177.cbd4407ecc7244a0bf6d3b4d8cd83569.1750, fullName: Optional(givenName: Rudolf familyName: Farkas ), email: Optional("ptdz4jhxyh@privaterelay.appleid.com")

        let userCredentials1: UserCredentials? = try? KeychainItem(account: UserCredentials.keychainAccount).readItem()
        printClassAndFunc(info: userCredentials1.debugDescription)
        let userCredentials2: UserCredentials? = KeychainItem.currentUserCredentials
        printClassAndFunc(info: userCredentials2.debugDescription)

        let userCred = UserCredentials(id: "000177.cbd4407ecc7244a0bf6d3b4d8cd83569.1750", fullName: "Rudolf Farkas", email: "ptdz4jhxyh@privaterelay.appleid.com")

        do {
            try KeychainItem(account: UserCredentials.keychainAccount).saveItem(userCred)
        } catch {
            XCTFail("saveItem failed")
        }

        let userCredentials3: UserCredentials? = try? KeychainItem(account: UserCredentials.keychainAccount).readItem()
        XCTAssertEqual(userCredentials3, userCred)
        XCTAssertEqual(userCredentials3?.id, "000177.cbd4407ecc7244a0bf6d3b4d8cd83569.1750")
    }
}
