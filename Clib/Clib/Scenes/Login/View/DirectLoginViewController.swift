//
//  DirectLoginViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/31.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class DirectLoginViewController: UIViewController {

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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("로그인", for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원가입", for: .normal)
        button.backgroundColor = .brown
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
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

        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        emailStackView.addArrangedSubview(emailTextField)
        emailStackView.addArrangedSubview(emailTextFieldUnderLine)
        
        passwordStackView.addArrangedSubview(passwordTextField)
        passwordStackView.addArrangedSubview(passwordTextFieldUnderLine)
        
        buttonStackView.addArrangedSubview(loginButton)
        buttonStackView.addArrangedSubview(signupButton)
        
        stackView.addArrangedSubview(emailStackView)
        stackView.addArrangedSubview(passwordStackView)
        stackView.addArrangedSubview(buttonStackView)
        
        view.addSubview(stackView)
        
        emailStackView.heightAnchor.constraint(
            equalToConstant: 49)
            .isActive = true
        passwordStackView.heightAnchor.constraint(
            equalToConstant: 49)
            .isActive = true
        buttonStackView.heightAnchor.constraint(
            equalToConstant: 110)
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
            equalToConstant: 270)
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
        
        passwordTextFieldUnderLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        passwordTextFieldUnderLine.leadingAnchor.constraint(equalTo: passwordStackView.leadingAnchor).isActive = true
        passwordTextFieldUnderLine.trailingAnchor.constraint(equalTo: passwordStackView.trailingAnchor).isActive = true
    }

}
