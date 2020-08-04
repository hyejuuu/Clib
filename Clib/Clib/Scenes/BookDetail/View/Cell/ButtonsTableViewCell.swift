//
//  ButtonsTableViewCell.swift
//  Clib
//
//  Created by 이혜주 on 2020/06/24.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit
import CoreData

class ButtonsTableViewCell: UITableViewCell {
    
    var bookMarkCallBack: ((Bool)->())?
    var writeCallBack: (()->())?
    var isbn: String?
    var itemId: String?
    
    private let topLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        return view
    }()
    
    private let bottomLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        return view
    }()
    
    private let bookMarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    private let writeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("작성", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    private let moveToSiteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("자세히보기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        writeButton.addTarget(self,
                              action: #selector(touchUpWriteButton),
                              for: .touchUpInside)
        moveToSiteButton.addTarget(self,
                                   action: #selector(touchUpMoveToSiteButton),
                                   for: .touchUpInside)
        bookMarkButton.addTarget(self,
                                 action: #selector(touchUpBookMarkButton),
                                 for: .touchUpInside)
        
        buttonStackView.addArrangedSubview(writeButton)
        buttonStackView.addArrangedSubview(bookMarkButton)
        buttonStackView.addArrangedSubview(moveToSiteButton)
        addSubview(topLineView)
        addSubview(buttonStackView)
        addSubview(bottomLineView)
        
        topLineView.topAnchor.constraint(
            equalTo: topAnchor)
            .isActive = true
        topLineView.heightAnchor.constraint(
            equalToConstant: 1)
            .isActive = true
        topLineView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 20)
            .isActive = true
        topLineView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -20)
            .isActive = true
        
        buttonStackView.topAnchor.constraint(
            equalTo: topLineView.bottomAnchor,
            constant: 10)
            .isActive = true
        buttonStackView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 10)
            .isActive = true
        buttonStackView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -10)
            .isActive = true
        buttonStackView.bottomAnchor.constraint(
            equalTo: bottomLineView.topAnchor,
            constant: -10)
            .isActive = true
        
        bottomLineView.topAnchor.constraint(
            equalTo: buttonStackView.bottomAnchor,
            constant: 10)
            .isActive = true
        bottomLineView.heightAnchor.constraint(
            equalToConstant: 1)
            .isActive = true
        bottomLineView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 20)
            .isActive = true
        bottomLineView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -20)
            .isActive = true
        bottomLineView.bottomAnchor.constraint(
            equalTo: bottomAnchor)
            .isActive = true
    
    }
    
    @objc private func touchUpBookMarkButton() {
        if bookMarkButton.titleLabel?.text == "목록에 저장" {
            bookMarkCallBack?(true)
            bookMarkButton.setTitle("목록에서 삭제", for: .normal)
        } else {
            bookMarkCallBack?(false)
            bookMarkButton.setTitle("목록에 저장", for: .normal)
        }
    }
    
    @objc private func touchUpWriteButton() {
        writeCallBack?()
    }
    
    @objc private func touchUpMoveToSiteButton() {
        guard let itemId = itemId,
            let url = URL(string: "https://www.aladin.co.kr/shop/wproduct.aspx?ItemId=\(itemId)"),
           UIApplication.shared.canOpenURL(url) else { return }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func configure(_ isSave: Bool) {
        if isSave {
            bookMarkButton.setTitle("목록에서 삭제", for: .normal)
        } else {
            bookMarkButton.setTitle("목록에 저장", for: .normal)
        }
    }
}
