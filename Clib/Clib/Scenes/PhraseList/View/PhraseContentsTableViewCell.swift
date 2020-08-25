//
//  PhraseContentsTableViewCell.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/30.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class PhraseContentsTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "명언"
        label.font = .systemFont(ofSize: 17,
                                 weight: .semibold)
        return label
    }()
    
    private let pageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let contentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(pageLabel)
        contentView.addSubview(contentsLabel)
        
        titleLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -20).isActive = true
        
        pageLabel.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor,
            constant: 10).isActive = true
        pageLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 20).isActive = true
        pageLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -20).isActive = true
        
        contentsLabel.topAnchor.constraint(
            equalTo: pageLabel.bottomAnchor,
            constant: 10).isActive = true
        contentsLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 20).isActive = true
        contentsLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -20).isActive = true
        contentsLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -20).isActive = true
    }
    
    func configure(page: String?, contents: String?) {
        guard let page = page else { return }
        pageLabel.text = "p.\(page)"
        contentsLabel.text = contents
    }

}
