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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        
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
