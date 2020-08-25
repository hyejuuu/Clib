//
//  BookTableViewCell.swift
//  Clib
//
//  Created by 이혜주 on 2020/06/24.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    private let imageManager: ImageManagerProtocol = ImageManager()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let starRateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "iconStarYellow"),
                        for: .normal)
        button.setTitle("5.0",
                        for: .normal)
        button.setTitleColor(.gray,
                             for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
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
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(starRateButton)
        
        contentView.addSubview(coverImageView)
        contentView.addSubview(stackView)
        
        starRateButton.widthAnchor.constraint(
            equalToConstant: 40)
            .isActive = true
        
        coverImageView.centerYAnchor.constraint(
            equalTo: contentView.centerYAnchor)
            .isActive = true
        coverImageView.widthAnchor.constraint(
            equalTo: contentView.widthAnchor,
            multiplier: 0.25)
            .isActive = true
        coverImageView.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 10)
            .isActive = true
        coverImageView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -10)
            .isActive = true
        coverImageView.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 15)
            .isActive = true
        
        stackView.topAnchor.constraint(
            equalTo: coverImageView.topAnchor,
            constant: 10)
            .isActive = true
        stackView.leadingAnchor.constraint(
            equalTo: coverImageView.trailingAnchor,
            constant: 15)
            .isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -15)
            .isActive = true
        stackView.bottomAnchor.constraint(
            lessThanOrEqualTo: coverImageView.bottomAnchor,
            constant: -10)
            .isActive = true
        
    }
    
    private func setImage(urlString: String) {
        imageManager.fetchImage(urlString: urlString) { [weak self] result in
            switch result {
            case .failure(let error):
                return
            case .success(let image):
                DispatchQueue.main.async {
                    self?.coverImageView.image = image
                }
            }
        }
    }
    
    func configure(book: Book) {
        setImage(urlString: book.cover)
        titleLabel.text = book.title
        authorLabel.text = book.author
    }
}
