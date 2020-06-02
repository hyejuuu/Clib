//
//  MainSectionHeaderView.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/25.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class MainSectionHeaderView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(separatorLine)
        addSubview(titleLabel)
        
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
            equalTo: trailingAnchor,
            constant: -20)
            .isActive = true
        titleLabel.centerYAnchor.constraint(
            equalTo: centerYAnchor)
            .isActive = true
    }
    
}
