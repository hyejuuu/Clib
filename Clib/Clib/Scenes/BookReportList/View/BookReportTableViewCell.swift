//
//  BookReportTableViewCell.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/23.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class BookReportTableViewCell: UITableViewCell {
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        selectionStyle = .none
        
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        
        coverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor, multiplier: 1.3).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
    
    func configure(_ bookReport: BookReport) {
        titleLabel.text = bookReport.title
    }
}
