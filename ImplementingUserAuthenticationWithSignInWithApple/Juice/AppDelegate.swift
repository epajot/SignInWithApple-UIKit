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
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { credentialState, _ in
            var info = ""
            switch credentialState {
            case .authorized:
                info = "The Apple ID credential is valid."
            case .revoked, .notFound:
                info = "The Apple ID credential is either revoked or was not found, so show the sign-in UI."
                DispatchQueue.main.async {
                    self.window?.rootViewController?.showLoginViewController()
                }
            default:
                break
            }
            self.printClassAndFunc(info: info)
        }
        return true
    }
}
