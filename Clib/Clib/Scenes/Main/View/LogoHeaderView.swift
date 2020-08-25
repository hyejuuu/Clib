//
//  LogoHeaderView.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/25.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class LogoHeaderView: UIView {

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "clibLogo")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(logoImageView)
        logoImageView.topAnchor.constraint(
            equalTo: topAnchor)
            .isActive = true
        logoImageView.leadingAnchor.constraint(
            equalTo: leadingAnchor)
            .isActive = true
        logoImageView.trailingAnchor.constraint(
            equalTo: trailingAnchor)
            .isActive = true
        logoImageView.bottomAnchor.constraint(
            equalTo: bottomAnchor)
            .isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
