//
//  ViewController.swift
//  SignInWithApple-UIKit
//
//  Created by Rudolf Farkas on 01.10.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

/*
 First we need to import a framework called “AuthenticationServices”
 AuthenticationServices was added to the SDK last year in iOS 12 and is used to handle passwords saved in the keychain. Now it’s also responsible of the Sign In with Apple Feature.
 */

import AuthenticationServices
import UIKit

class ViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    @IBOutlet var vStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         After that , adding the button is very simple — Just create a button from class ASAuthorizationAppleIDButton.
         */
        // Creating the button
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(appleIDButtonTap), for: .touchUpInside)

        vStackView.addArrangedSubview(button)
    }

    /*
     After we add the button, a target and an action, we need to response to user tap.
     */

    /*
     Open the Dialog

     The response for the button tap contains 7 steps:
     Create an instance of ASAuthorizationAppleIDProvider. This provider is responsible for generating requests for authentication based on AppleID.
     From this provider, call “createRequest ()” method.
     Define what scopes you want to receive from the user. Currently, only Email and Full name are available.
     Define the controller delegate, so you can respond to the user actions in the dialog.
     Provide a presentationContextProvider, so the controller can tell from what window to open.
     Create an AuthorizationController from those requests.
     Call performRequests method.
     */

    // Responding to the button tap
    @objc func appleIDButtonTap() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    /*
     This will open a dialog for the user, but with some issues, you need to be aware of:
     The user can edit his first and last name before sharing it with the app.
     If the user has several email addresses associated to his account, he can choose each one of them.
     The user can choose to hide his real email from the app and Apple will generate a random email for him. Now, the user can’t see the random email Apple generated for him and the app can’t see the real email for the user. Also, Apple generates the same email next time; the user will try to sign up/into your app. This is extremely important since a lot of apps are base their users account on email addresses.

     */

    /*
     Response to user Authorization

     The delegate we set for the controller has 2 methods: One is success (didCompleteWithAuthorization) and other is error.
     Let’s go over the “didCompleteWithAuthorization”.
     So besides the controller itself, this method has an additional parameter called “authorization” from type “ASAuthorization”. This object contains all the required data from the authorization process
     */

    // Extract email and useriD
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            if let email = credential.email {
//                signWithEmail(email: email)
//            }
//            let userId = credential.user
//            saveUserId(id: userId)
//        }
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential:
            if let email = credential.email {
                signWithEmail(email: email)
            }
            let userId = credential.user
            saveUserId(id: userId)
        case let credential as ASPasswordCredential:
            let user = credential.user
            signWithUserID(userID: user)
        default:
            break
        }
    }

    private func signWithEmail(email: String) {
        // TODO:
    }

    private func saveUserId(id: String) {
        // TODO:
    }

    /*
     We need the extract the credential from the authorization object and there we have it — the user data.
     What’s included here?
     First of all, we have the basic data — Full Name and Email, and just to remind you, it doesn’t have to be the real name and email of the user.
     On the other hand, we also have some more info which you may find useful. For example, we have a user identifier. You should save it in your app keychain.
     */

    /*
     Handling Changes in Apple ID State

     We know that the user can sign out from his Apple ID account or not letting the app permission to use it. Fortunately, we have an explicit notification for that, which is called NSNotification.Name.ASAuthorizationAppleIDProviderCredentialRevoked.
     You need to listen to this notification and then get the credential state for the user ID you got when the user logged in by using ASAuthorizationAppleIDProvider.
     */

    // open func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?)

    // Responding to state changes
    func addObserverForAppleIDChangeNotification() {
        // THIS FAILS TO COMPILE
        // NotificationCenter.addObserver(self, selector: #selector(appleIDStateChanged), name: Notification.Name.ASAuthorizationAppleIDProviderCredentialRevoked, object: nil) // Extra argument 'name' in call
    }

    // Responding to state changes
    @objc func appleIDStateChanged() {
        let provider = ASAuthorizationAppleIDProvider()
        provider.getCredentialState(forUserID: "12345") { credentialState, _ in
            switch credentialState {
            case .authorized:
                self.keepOnWithYourLife()
            case .revoked:
                self.logout()
            case .notFound:
                self.logout()
            default:
                break
            }
        }
    }

    private func keepOnWithYourLife() {
        // TODO:
    }

    private func logout() {
        // TODO:
    }

    /*
     Existing Accounts

     If your user signed using email and password before and the password is attached to his keychain, then it will also offer the user to sign in using his existing email address and password.
     In order to handle the response, just check the authorization.credential in the didCompleteWithAuthorization delegate method and in the case from type ASPasswordCredential, you know that the user signed in with a saved email and password.
     */

    // Sending both password and Apple ID requests
    func performExistingAccountSetupFlows() {
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    // Define between password credential and appleID credential
    // THIS WOULD REDEFINE THE SAME FUNC
    // I INTEGRATED THE CODE IN THE FIRST FUNC DEFINITION ABOVE
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        switch authorization.credential {
//        case let credential as ASAuthorizationAppleIDCredential:
//            if let email = credential.email {
//                signWithEmail(email: email)
//            }
//        case let credential as ASPasswordCredential:
//            let user = credential.user
//            signWithUserID(userID: user)
//        default:
//            break
//        }
//    }

    private func signWithUserID(userID: String) {
        // TODO:
    }

    /*
     Creating a Generic Solution for Sign In with the Third- Party Provider

     Now, that we have Google, Facebook, and Apple ID login. You should think of creating a robust and unified solution for signing and logging to your app.
     One of the methods of doing that, is to create a connector for each one of your login methods, which conform to some “authentication connector protocol”. So all you will have to do is to call that connector with some connect () protocol method and received success or failure with an email and a name.
     That will make your work much simpler.

     Web/Android Solution
     
     This is a tricky part — if currently, your app is using some third-party authentication service, such as Google or Facebook; you will have to implement Sign In with Apple method. This is Apple guidelines and if your app is cross-platform, for example, if you have a web version of your app, it means that you probably will have to implement Sign In with Apple on your web as well.
     Remember, the user can share a fake email with you and he will have to do it also on the web.
     Apple releases a JavaScript SDK especially for that, letting you build your own controls for web and for Android platforms, so you can make a cross-platform solution of the new authentication method.
     iOS

     */

    // REQUIRED BY ASAuthorizationControllerPresentationContextProviding
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // TODO:
        return ASPresentationAnchor()
    }
}
