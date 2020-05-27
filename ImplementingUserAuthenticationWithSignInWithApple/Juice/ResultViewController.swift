/*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 Main application view controller.
 */

import AuthenticationServices
import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var userIdentifierLabel: UILabel!
    @IBOutlet var givenNameLabel: UILabel!
    @IBOutlet var familyNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var signOutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        userIdentifierLabel.text = KeychainItem.currentUserIdentifier
        printClassAndFunc(info: "@userIdentifier= \(String(describing: userIdentifierLabel.text))")
    }

    @IBAction func signOutButtonPressed() {
        // For the purpose of this demo app, delete the user identifier that was previously stored in the keychain.
        KeychainItem.deleteUserIdentifierFromKeychain()

        // Clear the user interface.
        userIdentifierLabel.text = ""
        givenNameLabel.text = ""
        familyNameLabel.text = ""
        emailLabel.text = ""

        // Display the login controller again.
        DispatchQueue.main.async {
            self.showLoginViewController()
        }
    }
}
