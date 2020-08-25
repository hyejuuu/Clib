//
//  AladinFooterView.swift
//  Clib
//
//  Created by 이혜주 on 2020/08/04.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class AladinFooterView: UIView {

    let aladinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "도서 DB 제공 : 알라딘 인터넷서점(www.aladin.co.kr)"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
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
        backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        
        addSubview(aladinLabel)
        
        aladinLabel.topAnchor.constraint(
            equalTo: topAnchor, constant: 5)
            .isActive = true
        aladinLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 10)
            .isActive = true
        aladinLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -10)
            .isActive = true
        aladinLabel.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -5)
            .isActive = true
    }
}
