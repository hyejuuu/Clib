//
//  NickNameSignUpViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/11.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class NickNameSignUpViewController: UIViewController {
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("완료", for: .normal)
        return button
    }()
    
    private let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "닉네임을 입력하세요"
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let nickNameTextFieldUnderLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    private let nickNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: completeButton)
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        completeButton.addTarget(self,
                                 action: #selector(touchUpCompleteButton),
                                 for: .touchUpInside)
        
        nickNameStackView.addArrangedSubview(nickNameTextField)
        nickNameStackView.addArrangedSubview(nickNameTextFieldUnderLine)
        
        view.addSubview(nickNameStackView)
        
        nickNameStackView.centerXAnchor.constraint(
            equalTo: view.centerXAnchor)
            .isActive = true
        nickNameStackView.centerYAnchor.constraint(
            equalTo: view.centerYAnchor)
            .isActive = true
        nickNameStackView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 50)
            .isActive = true
        nickNameStackView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -50)
            .isActive = true
        
        nickNameTextFieldUnderLine.heightAnchor.constraint(
            equalToConstant: 1)
            .isActive = true
        nickNameTextFieldUnderLine.leadingAnchor.constraint(
            equalTo: nickNameStackView.leadingAnchor)
            .isActive = true
        nickNameTextFieldUnderLine.trailingAnchor.constraint(
            equalTo: nickNameStackView.trailingAnchor)
            .isActive = true
        
    }
    
    @objc private func touchUpCompleteButton() {
        // 회원가입
    }
}
