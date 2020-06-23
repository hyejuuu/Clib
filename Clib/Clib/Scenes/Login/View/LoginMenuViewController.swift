//
//  LoginMenuViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/31.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class LoginMenuViewController: UIViewController {

    private let appleLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("apple로 로그인", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let googleLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("google로 로그인", for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let directLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("직접 로그인", for: .normal)
        button.backgroundColor = .brown
        button.setTitleColor(.white, for: .normal)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(solution(3, [3], [1]))

        setupLayout()
    }

    func solution(_ n:Int, _ lost:[Int], _ reserve:[Int]) -> Int {
        var students: [Int] = Array(repeating: 1, count: n)
        
        for index in lost {
            students[index-1] -= 1
        }
        
        for index in reserve {
            students[index-1] += 1
        }
        
        for index in 0..<n {
            if students[index] == 0 {
                if index != 0 {
                    if students[index - 1] > 1 {
                        students[index] += 1
                        students[index-1] -= 1
                    }
                } else if index != n - 1 {
                    if students[index + 1] > 1 {
                        students[index] += 1
                        students[index+1] -= 1
                    }
                }
            }
        }
        
        var result = 0
        
        for element in students {
            if element > 0 { result += 1 }
        }
        
        return result
    }

    private func setupLayout() {
        directLoginButton.addTarget(self, action: #selector(touchUpDirectLoginButton), for: .touchUpInside)
        
        loginMenuStackView.addArrangedSubview(appleLoginButton)
        loginMenuStackView.addArrangedSubview(googleLoginButton)
        loginMenuStackView.addArrangedSubview(directLoginButton)
        
        view.addSubview(loginMenuStackView)
        
        loginMenuStackView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 50).isActive = true
        loginMenuStackView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -50).isActive = true
        loginMenuStackView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -80).isActive = true
        loginMenuStackView.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    @objc private func touchUpDirectLoginButton() {
        navigationController?.pushViewController(DirectLoginViewController(), animated: true)
    }
}
