//
//  MainSectionHeaderView.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/25.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class MainSectionHeaderView: UIView {

    var callback: (()->())?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("더보기 →",
                        for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
                             for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        moreButton.addTarget(self,
                             action: #selector(touchUpMoreButton),
                             for: .touchUpInside)
        
        addSubview(separatorLine)
        addSubview(titleLabel)
        addSubview(moreButton)
        
        separatorLine.topAnchor.constraint(
            equalTo: topAnchor)
            .isActive = true
        separatorLine.leadingAnchor.constraint(
            equalTo: leadingAnchor)
            .isActive = true
        separatorLine.trailingAnchor.constraint(
            equalTo: trailingAnchor)
            .isActive = true
        separatorLine.heightAnchor.constraint(
            equalToConstant: 1)
            .isActive = true
        
        titleLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 20)
            .isActive = true
        titleLabel.trailingAnchor.constraint(
            equalTo: moreButton.leadingAnchor,
            constant: -20)
            .isActive = true
        titleLabel.centerYAnchor.constraint(
            equalTo: centerYAnchor)
            .isActive = true
        
        moreButton.widthAnchor.constraint(
            equalToConstant: 50)
            .isActive = true
        moreButton.heightAnchor.constraint(
            equalTo: heightAnchor,
            constant: -10)
            .isActive = true
        moreButton.bottomAnchor.constraint(
            equalTo: bottomAnchor)
            .isActive = true
        moreButton.leadingAnchor.constraint(
            equalTo: titleLabel.trailingAnchor,
            constant: 20)
            .isActive = true
        moreButton.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -10)
            .isActive = true
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    @objc private func touchUpMoreButton() {
        callback?()
    }
}
