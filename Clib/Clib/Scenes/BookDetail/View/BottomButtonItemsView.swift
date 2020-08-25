//
//  BottomButtonItemsView.swift
//  Clib
//
//  Created by 이혜주 on 2020/06/01.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class BottomButtonItemsView: UIView {

    var writeReviewCallBack: (()->())?
    var writeBookReportCallBack: (()->())?
    var moveToSiteCallBack: (()->())?
    
    private let writeReviewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("후기 작성", for: .normal)
        button.backgroundColor = .brown
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    private let writeBookReportButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("독후감 작성", for: .normal)
        button.backgroundColor = .brown
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    private let moveToSiteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("자세히보기", for: .normal)
        button.backgroundColor = .brown
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        backgroundColor = .brown
        
        buttonStackView.addArrangedSubview(writeReviewButton)
        buttonStackView.addArrangedSubview(writeBookReportButton)
        buttonStackView.addArrangedSubview(moveToSiteButton)
        addSubview(buttonStackView)
        
        buttonStackView.topAnchor.constraint(
            equalTo: topAnchor,
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
            equalTo: bottomAnchor,
            constant: -10)
            .isActive = true
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
