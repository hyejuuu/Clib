//
//  DirectSignUpViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/11.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit
import FirebaseAuth

class DirectSignUpViewController: UIViewController {
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black,
                             for: .normal)
        button.setTitle("다음",
                        for: .normal)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "아이디를 입력하세요"
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let emailTextFieldUnderLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    private let emailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "비밀번호를 입력하세요"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let passwordTextFieldUnderLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 30
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem
            = UIBarButtonItem(customView: nextButton)
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        nextButton.addTarget(self,
                             action: #selector(touchUpNextButton),
                             for: .touchUpInside)
        
        emailStackView.addArrangedSubview(emailTextField)
        emailStackView.addArrangedSubview(emailTextFieldUnderLine)
        
        passwordStackView.addArrangedSubview(passwordTextField)
        passwordStackView.addArrangedSubview(passwordTextFieldUnderLine)
        
        stackView.addArrangedSubview(emailStackView)
        stackView.addArrangedSubview(passwordStackView)
        
        view.addSubview(stackView)
        
        emailStackView.heightAnchor.constraint(
            equalToConstant: 49)
            .isActive = true
        passwordStackView.heightAnchor.constraint(
            equalToConstant: 49)
            .isActive = true
        
        stackView.centerXAnchor.constraint(
            equalTo: view.centerXAnchor)
            .isActive = true
        stackView.centerYAnchor.constraint(
            equalTo: view.centerYAnchor)
            .isActive = true
        stackView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 50)
            .isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -50)
            .isActive = true
        stackView.heightAnchor.constraint(
            equalToConstant: 130)
            .isActive = true
        
        emailTextFieldUnderLine.heightAnchor.constraint(
            equalToConstant: 1)
            .isActive = true
        emailTextFieldUnderLine.leadingAnchor.constraint(
            equalTo: emailStackView.leadingAnchor)
            .isActive = true
        emailTextFieldUnderLine.trailingAnchor.constraint(
            equalTo: emailStackView.trailingAnchor)
            .isActive = true
        
        passwordTextFieldUnderLine.heightAnchor.constraint(
            equalToConstant: 1)
            .isActive = true
        passwordTextFieldUnderLine.leadingAnchor.constraint(
            equalTo: passwordStackView.leadingAnchor)
            .isActive = true
        passwordTextFieldUnderLine.trailingAnchor.constraint(
            equalTo: passwordStackView.trailingAnchor)
            .isActive = true
    }
    
    @objc private func touchUpNextButton() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            email.isEmpty == false,
            password.isEmpty == false else {
                let alertController
                    = UIAlertController(title: "알림",
                                        message: "모든 항목을 채워주세요",
                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인",
                                             style: .cancel)
                alertController.addAction(okAction)
                present(alertController,
                        animated: true)
                return
        }
        
        Auth.auth().createUser(withEmail: email,
                               password: password) { [weak self] user, error in
            if error != nil {
                return
            }

            Auth.auth().signIn(withEmail: email,
                               password: password) { [weak self] result, error in
                if error != nil {
                    return
                }

                DispatchQueue.main.async {
                    let tabBarViewController = TabBarViewController()
                    UIApplication.shared.keyWindow?.rootViewController = tabBarViewController
                }
            }
            
        }
    }

}
