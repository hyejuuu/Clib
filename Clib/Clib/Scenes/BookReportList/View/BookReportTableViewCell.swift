//
//  BookReportTableViewCell.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/23.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class BookReportTableViewCell: UITableViewCell {
    
    private let imageManager: ImageManagerProtocol = ImageManager()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starRateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "iconStarYellow"), for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        return button
    }()
    
    private let editDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let contentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
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
        
        contentsStackView.addArrangedSubview(titleLabel)
        contentsStackView.addArrangedSubview(starRateButton)
        contentsStackView.addArrangedSubview(editDateLabel)
        
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
            equalToConstant: 60)
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
            constant: 15)
            .isActive = true
        contentsStackView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -20)
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
    
    func configure(_ bookReport: BookReport) {
        guard let title = bookReport.title,
            let imageUrl = bookReport.imageUrl,
            let rate = bookReport.rate,
            let date = bookReport.editDate else { return }
        titleLabel.text = title
        setImage(urlString: imageUrl)
        starRateButton.setTitle(String(rate), for: .normal)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"

        editDateLabel.text = dateFormatter.string(from: date)
    }
}
