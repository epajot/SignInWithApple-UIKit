/*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 Main application view controller.
 */

import AuthenticationServices
import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var userIdentifierLabel: UILabel!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var signOutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateCredentialLabels()
        printClassAndFunc(info: "@userIdentifier= \(String(describing: userIdentifierLabel.text))")
    }

    func updateCredentialLabels() {
        printClassAndFunc()
        let currentUserCredentials = KeychainItem.currentUserCredentials
        userIdentifierLabel.text = currentUserCredentials.id
        fullNameLabel.text = currentUserCredentials.fullName
        emailLabel.text = currentUserCredentials.email
    }

    @IBAction func signOutButtonPressed() {
        // For the purpose of this demo app, delete the user identifier that was previously stored in the keychain.
        KeychainItem.deleteUserIdentifierFromKeychain()

        // Clear the user interface.
        userIdentifierLabel.text = ""
        fullNameLabel.text = ""
        emailLabel.text = ""

        // Display the login controller again.
        DispatchQueue.main.async {
            self.showLoginViewController()
        }
    }
}
