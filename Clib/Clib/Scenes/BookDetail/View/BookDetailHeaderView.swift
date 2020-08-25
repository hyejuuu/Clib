//
//  BookDetailHeaderView.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/31.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class BookDetailHeaderView: UIView {

    var rating: Float? {
        willSet {
            starRatingView.rating = newValue ?? 0.0
        }
    }
    var ratingCallback: ((Float)->())? {
        willSet {
            if newValue != nil {
                starRatingView.ratingCallback = newValue
            }
        }
    }
    
    var gestureCallBack: (()->())?
    
    private let imageManager: ImageManagerProtocol = ImageManager()
    private let imageViewTapGesture = UITapGestureRecognizer()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = #colorLiteral(red: 0.2274509804, green: 0.2274509804, blue: 0.2274509804, alpha: 1)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let starRatingView: StarRatingView = {
        let starRatingView = StarRatingView(color: .yellow, isEnabled: true)
        starRatingView.translatesAutoresizingMaskIntoConstraints = false
        return starRatingView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageViewTapGesture.delegate = self
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        coverImageView.addGestureRecognizer(imageViewTapGesture)
        
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        
        addSubview(coverImageView)
        addSubview(stackView)
        addSubview(starRatingView)
        
        coverImageView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: 30)
            .isActive = true
        
//        let coverImageViewBottomConstraint = coverImageView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -15)
//        coverImageViewBottomConstraint.priority = UILayoutPriority.defaultHigh
//        coverImageViewBottomConstraint.isActive = true
        
        coverImageView.centerXAnchor.constraint(
            equalTo: centerXAnchor)
            .isActive = true
        coverImageView.widthAnchor.constraint(
            equalTo: widthAnchor,
            multiplier: 0.3)
            .isActive = true
        coverImageView.heightAnchor.constraint(
            equalTo: coverImageView.widthAnchor,
            multiplier: 1.3)
            .isActive = true
        
        stackView.topAnchor.constraint(
            equalTo: coverImageView.bottomAnchor,
            constant: 15)
            .isActive = true
        stackView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 15)
            .isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -15)
            .isActive = true
        
        starRatingView.topAnchor.constraint(
            equalTo: stackView.bottomAnchor,
            constant: 20)
            .isActive = true
        starRatingView.centerXAnchor.constraint(
            equalTo: centerXAnchor)
            .isActive = true
        starRatingView.widthAnchor.constraint(
            equalToConstant: 190)
            .isActive = true
        starRatingView.heightAnchor.constraint(
            equalToConstant: 30)
            .isActive = true
        starRatingView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -30)
            .isActive = true
        
    }
    
    private func setImage(urlString: String) {
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
    
    func configure(book: Book) {
        titleLabel.text = book.title
        authorLabel.text = book.author
        
        let categoryComponents = book.categoryName.components(separatedBy: ">")
        categoryLabel.text = categoryComponents.count != 1 ? categoryComponents[1] : categoryComponents[0]
        setImage(urlString: book.cover)
    }
}

extension BookDetailHeaderView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        gestureCallBack?()
        return false
    }
}
