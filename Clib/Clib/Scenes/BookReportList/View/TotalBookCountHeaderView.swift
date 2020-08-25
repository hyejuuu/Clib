//
//  TotalBookCountHeaderView.swift
//  Clib
//
//  Created by 이혜주 on 2020/08/04.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class TotalBookCountHeaderView: UIView {

    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
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
        
        addSubview(countLabel)
        
        countLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: 10)
            .isActive = true
        countLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 10)
            .isActive = true
        countLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -10)
            .isActive = true
        countLabel.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -10)
            .isActive = true
    }
    
    func configure(count: Int) {
        countLabel.text = "내가 읽은 책 수: \(count)"
    }


}
