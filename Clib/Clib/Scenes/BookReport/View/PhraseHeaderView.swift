//
//  PhraseHeaderView.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/21.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class PhraseHeaderView: UIView {

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
        책을 읽고
        기억하고 싶은 구절을
        남겨보세요 :)
        """
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
        addSubview(messageLabel)
        
        messageLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: 10)
            .isActive = true
        messageLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 10)
            .isActive = true
        messageLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -10)
            .isActive = true
        messageLabel.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -10)
            .isActive = true
    }

}
