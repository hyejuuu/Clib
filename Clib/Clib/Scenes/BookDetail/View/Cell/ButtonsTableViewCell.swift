//
//  ButtonsTableViewCell.swift
//  Clib
//
//  Created by 이혜주 on 2020/06/24.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class ButtonsTableViewCell: UITableViewCell {
    
    var writeReviewCallBack: (()->())?
    var writeBookReportCallBack: (()->())?
    var moveToSiteCallBack: (()->())?
    
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
    
    private let writeReviewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("후기 작성", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    private let writeBookReportButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("독후감 작성", for: .normal)
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
        
        writeReviewButton.addTarget(self,
                                    action: #selector(touchUpWriteReviewButton),
                                    for: .touchUpInside)
        writeBookReportButton.addTarget(self,
                                        action: #selector(touchUpWriteBookReportButton),
                                        for: .touchUpInside)
        moveToSiteButton.addTarget(self,
                                   action: #selector(touchUpMoveToSiteButton),
                                   for: .touchUpInside)
        
//        buttonStackView.addArrangedSubview(writeReviewButton)
        buttonStackView.addArrangedSubview(writeBookReportButton)
        buttonStackView.addArrangedSubview(moveToSiteButton)
        addSubview(topLineView)
        addSubview(buttonStackView)
        addSubview(bottomLineView)
        
        topLineView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        topLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        topLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
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
        
        bottomLineView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 10).isActive = true
        bottomLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bottomLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        bottomLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        bottomLineView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    }
    
    @objc private func touchUpWriteReviewButton() {
        writeReviewCallBack?()
    }
    
    @objc private func touchUpWriteBookReportButton() {
        writeBookReportCallBack?()
    }
    
    @objc private func touchUpMoveToSiteButton() {
        moveToSiteCallBack?()
    }
}
