//
//  BookDetailHeaderView.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/31.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class BookDetailHeaderView: UIView {

    private let imageManager: ImageManagerProtocol = ImageManager()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "category"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = #colorLiteral(red: 0.2274509804, green: 0.2274509804, blue: 0.2274509804, alpha: 1)
        label.numberOfLines = 2
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
        label.numberOfLines = 2
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        
        addSubview(coverImageView)
        addSubview(stackView)
        
        coverImageView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: 15)
            .isActive = true
        
        let coverImageViewBottomConstraint = coverImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        coverImageViewBottomConstraint.priority = UILayoutPriority.defaultHigh
        coverImageViewBottomConstraint.isActive = true
        
        coverImageView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 20)
            .isActive = true
        coverImageView.widthAnchor.constraint(
            equalTo: widthAnchor,
            multiplier: 0.3)
            .isActive = true
        
        stackView.leadingAnchor.constraint(
            equalTo: coverImageView.trailingAnchor,
            constant: 10)
            .isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -15)
            .isActive = true
        stackView.bottomAnchor.constraint(
            equalTo: coverImageView.bottomAnchor,
            constant: -5)
            .isActive = true
    }
    
    func setImage(urlString: String) {
        imageManager.fetchImage(urlString: urlString) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                return
            case .success(let image):
                DispatchQueue.main.async {
                    self?.coverImageView.image = image
                }
            }
        }
    }
}
