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
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        return imageview
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
        
        coverImageView.widthAnchor.constraint(
            equalTo: contentView.widthAnchor)
            .isActive = true
        coverImageView.centerXAnchor.constraint(
            equalTo: contentView.centerXAnchor)
            .isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
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
    
}
