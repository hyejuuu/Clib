//
//  PhraseTableViewCell.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/21.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class WritePhraseTableViewCell: UITableViewCell {

    var deleteCallback: (()->())?
    var pageSaveCallback: ((String?)->())?
    var contentsSaveCallback: ((String?)->())?
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("삭제",
                        for: .normal)
        button.setTitleColor(.black,
                             for: .normal)
        return button
    }()
    
    private let pageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "페이지"
        return label
    }()
    
    private let pageTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "구절의 페이지를 입력해주세요."
        return textfield
    }()
    
    private let phraseTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "남길 구절"
        return label
    }()
    
    private let phraseTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        return textView
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        
        pageTextField.delegate = self
        phraseTextView.delegate = self
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        selectionStyle = .none
        
        deleteButton.addTarget(self,
                               action: #selector(touchUpDeleteButton),
                               for: .touchUpInside)
        pageTextField.addTarget(self,
                                action: #selector(textFieldDidChange(_:)),
                                for: .editingChanged)
        
        contentView.addSubview(deleteButton)
        contentView.addSubview(pageLabel)
        contentView.addSubview(pageTextField)
        contentView.addSubview(phraseTitleLabel)
        contentView.addSubview(phraseTextView)
        
        deleteButton.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 10)
            .isActive = true
        deleteButton.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -10)
            .isActive = true
        deleteButton.widthAnchor.constraint(
            equalToConstant: 50)
            .isActive = true
        deleteButton.heightAnchor.constraint(
            equalToConstant: 20)
            .isActive = true
        
        pageLabel.topAnchor.constraint(
            equalTo: deleteButton.bottomAnchor,
            constant: 10)
            .isActive = true
        pageLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 10)
            .isActive = true
        pageLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -10)
            .isActive = true
        
        pageTextField.topAnchor.constraint(
            equalTo: pageLabel.bottomAnchor,
            constant: 5)
            .isActive = true
        pageTextField.leadingAnchor.constraint(
            equalTo: pageLabel.leadingAnchor)
            .isActive = true
        pageTextField.trailingAnchor.constraint(
            equalTo: pageLabel.trailingAnchor)
            .isActive = true
        
        phraseTitleLabel.topAnchor.constraint(
            equalTo: pageTextField.bottomAnchor,
            constant: 20)
            .isActive = true
        phraseTitleLabel.leadingAnchor.constraint(
            equalTo: pageLabel.leadingAnchor)
            .isActive = true
        phraseTitleLabel.trailingAnchor.constraint(
            equalTo: pageLabel.trailingAnchor)
            .isActive = true
        
        phraseTextView.topAnchor.constraint(
            equalTo: phraseTitleLabel.bottomAnchor,
            constant: 5)
            .isActive = true
        phraseTextView.leadingAnchor.constraint(
            equalTo: pageLabel.leadingAnchor)
            .isActive = true
        phraseTextView.trailingAnchor.constraint(
            equalTo: pageLabel.trailingAnchor)
            .isActive = true
        phraseTextView.heightAnchor.constraint(
            equalToConstant: 100)
            .isActive = true
    }
    
    @objc private func touchUpDeleteButton() {
        deleteCallback?()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        pageSaveCallback?(textField.text)
    }
}

extension WritePhraseTableViewCell: UITextFieldDelegate {
}

extension WritePhraseTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        contentsSaveCallback?(textView.text)
    }
}
