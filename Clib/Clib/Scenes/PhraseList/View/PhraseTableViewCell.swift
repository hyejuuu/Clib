//
//  PhraseTableViewCell.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/30.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class PhraseTableViewCell: UITableViewCell {
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private let pageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let contentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private let contentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
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
        selectionStyle = .none
        
        contentsStackView.addArrangedSubview(pageLabel)
        contentsStackView.addArrangedSubview(contentsLabel)
        
        contentView.addSubview(coverImageView)
        contentView.addSubview(contentsStackView)
        
        coverImageView.centerYAnchor.constraint(
            equalTo: contentView.centerYAnchor)
            .isActive = true
        coverImageView.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 20)
            .isActive = true
        coverImageView.widthAnchor.constraint(
            equalToConstant: 50)
            .isActive = true
        coverImageView.heightAnchor.constraint(
            equalTo: coverImageView.widthAnchor,
            multiplier: 1.3)
            .isActive = true
        
        contentsStackView.topAnchor.constraint(
            equalTo: coverImageView.topAnchor,
            constant: 5)
            .isActive = true
        contentsStackView.bottomAnchor.constraint(
            lessThanOrEqualTo: coverImageView.bottomAnchor,
            constant: -5)
            .isActive = true
        contentsStackView.leadingAnchor.constraint(
            equalTo: coverImageView.trailingAnchor,
            constant: 20).isActive = true
        contentsStackView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -20).isActive = true
        
    }
    
    func configure(_ phrase: Phrase) {
        guard let page = phrase.page,
            let contents = phrase.contents else { return }
        pageLabel.text = "p.\(page)"
        contentsLabel.text = contents
    }
}
