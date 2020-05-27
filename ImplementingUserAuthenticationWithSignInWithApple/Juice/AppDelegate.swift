/*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 Main application delegate.
 */

import AuthenticationServices
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    /// - Tag: did_finish_launching
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.printClassAndFunc(info: "@")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserCredentials.id) { credentialState, _ in
            switch credentialState {
            case .authorized:
                self.printClassAndFunc(info: "@The Apple ID credential is valid.")
            case .revoked, .notFound:
                self.printClassAndFunc(info: "@The Apple ID credential is either revoked or was not found, so show the sign-in UI.")
                DispatchQueue.main.async {
                    self.window?.rootViewController?.showLoginViewController()
                }
            default:
                break
            }
        }
        return true
    }
}
