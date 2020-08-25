//
//  LoginMenuViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/31.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit
import AuthenticationServices
import FirebaseAuth
import CryptoKit
import GoogleSignIn
import Firebase

class LoginMenuViewController: UIViewController {

    private let appleLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("apple로 로그인",
                        for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white,
                             for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let googleLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("google로 로그인",
                        for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(.black,
                             for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let directLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("직접 로그인",
                        for: .normal)
        button.backgroundColor = .brown
        button.setTitleColor(.white,
                             for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let loginMenuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var nonce = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        addButtonTargets()
    }

    private func setupLayout() {
        
        loginMenuStackView.addArrangedSubview(appleLoginButton)
        loginMenuStackView.addArrangedSubview(googleLoginButton)
        loginMenuStackView.addArrangedSubview(directLoginButton)
        
        view.addSubview(loginMenuStackView)
        
        loginMenuStackView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 50)
            .isActive = true
        loginMenuStackView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -50)
            .isActive = true
        loginMenuStackView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -80)
            .isActive = true
        loginMenuStackView.heightAnchor.constraint(
            equalToConstant: 180)
            .isActive = true
    }
    
    private func addButtonTargets() {
        appleLoginButton.addTarget(self,
                                   action: #selector(appleLoginButtonDidTap),
                                   for: .touchUpInside)
        googleLoginButton.addTarget(self,
                                    action: #selector(googleLoginButtonDidTap),
                                    for: .touchUpInside)
        directLoginButton.addTarget(self,
                                    action: #selector(directLoginButtonDidTap),
                                    for: .touchUpInside)
    }
    
    @objc func appleLoginButtonDidTap() {
        let nonce = makeNonce()
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = nonce
        let authorizationController
            = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc func googleLoginButtonDidTap() {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @objc func directLoginButtonDidTap() {
        let directLoginViewController = DirectLoginViewController()
        navigationController?.pushViewController(directLoginViewController,
                                                 animated: true)
    }
}

//MARK: apple Login
extension LoginMenuViewController {
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }

    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hashFunction.digest(inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()

        return hashString
    }
    func makeNonce() -> String {
        let nonceString = randomNonceString()
        let nonce = sha256(nonceString)
        self.nonce = nonceString
        return nonce
    }
}

extension LoginMenuViewController: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let appleIDCredential
            = authorization.credential
                as? ASAuthorizationAppleIDCredential {
            UserDefaults.standard.set(appleIDCredential.user,
                                      forKey: "appleAuthorizedUserIdKey")
            guard let appleIDToken = appleIDCredential.identityToken else {
                return
            }
            
            guard let idTokenString = String(data: appleIDToken,
                                             encoding: .utf8) else {
                return
            }
            
            let firebaseCredential
                = OAuthProvider.credential(withProviderID: "apple.com",
                                           idToken: idTokenString,
                                           rawNonce: nonce)
            Auth.auth().signIn(with: firebaseCredential) { result, error in
                print("success")
            }
        }
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        print("failed")
    }
}

extension LoginMenuViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

//MARK: google sign in

extension LoginMenuViewController: GIDSignInDelegate {
    func sign(
        _ signIn: GIDSignIn!,
        didSignInFor user: GIDGoogleUser!,
        withError error: Error!
    ) {
        guard user != nil else {
            return
        }
        guard let authentication = user.authentication else {
            return
        }
        let credential
            = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                            accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { result, error in
            print(result)
        }
    }
}
