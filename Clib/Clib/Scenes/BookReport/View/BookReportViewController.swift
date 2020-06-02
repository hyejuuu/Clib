//
//  BookReportViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/31.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class BookReportViewController: UIViewController {

    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let bookReportTextView: UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.font = .systemFont(ofSize: 18)
        return textview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    private func setupLayout() {
        closeButton.addTarget(self,
                              action: #selector(touchUpCloseButton),
                              for: .touchUpInside)
        
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        view.addSubview(bookReportTextView)
        
        closeButton.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 10)
            .isActive = true
        closeButton.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 10)
            .isActive = true
        closeButton.widthAnchor.constraint(
            equalToConstant: 50)
            .isActive = true
        closeButton.heightAnchor.constraint(
            equalToConstant: 30)
            .isActive = true
        
        bookReportTextView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10).isActive = true
        bookReportTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        bookReportTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        bookReportTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }

    @objc private func touchUpCloseButton() {
        dismiss(animated: true)
    }
}
