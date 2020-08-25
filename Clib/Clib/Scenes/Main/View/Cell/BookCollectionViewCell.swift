//
//  BookCollectionViewCell.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/26.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    let imageManager: ImageManagerProtocol = ImageManager()
    
    private let coverImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 5
        return imageview
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        
        coverImageView.widthAnchor.constraint(
            equalTo: contentView.widthAnchor)
            .isActive = true
        coverImageView.heightAnchor.constraint(
            equalTo: coverImageView.widthAnchor,
            multiplier: 1.3)
            .isActive = true
        coverImageView.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 5)
            .isActive = true
        titleLabel.topAnchor.constraint(
            equalTo: coverImageView.bottomAnchor,
            constant: 5)
            .isActive = true
        titleLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 2)
            .isActive = true
        titleLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -2)
            .isActive = true
        
        authorLabel.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor,
            constant: 2)
            .isActive = true
        authorLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 2)
            .isActive = true
        authorLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -2)
            .isActive = true
        authorLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -5)
            .isActive = true
    }
    
    func setImage(urlString: String) {
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
