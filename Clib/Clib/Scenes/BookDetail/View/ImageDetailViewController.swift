//
//  ImageDetailViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/08/04.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {

    var isbn: String?
    private let bookService: BookServiceProtocol = BookService()
    private let imageManager: ImageManagerProtocol = ImageManager()
    
    private let imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        return scrollView
    }()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageScrollView.delegate = self

        fetchCoverImage()
        setupLayout()
    }
    
    private func fetchCoverImage() {
        guard let isbn = isbn else { return }
        
        bookService.fetchBookDataWithBigImage(isbn: isbn) { [weak self] result in
            switch result {
            case .success(let bookData):
                self?.setImage(urlString: bookData.cover)
            case .failure(let error):
                print(error)
            }
        }
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
    
    private func setupLayout() {
        view.backgroundColor = .black
        
        closeButton.addTarget(self,
                              action: #selector(touchUpCloseButton),
                              for: .touchUpInside)
        
        imageScrollView.addSubview(coverImageView)
        
        view.addSubview(imageScrollView)
        view.addSubview(closeButton)
        
        imageScrollView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        imageScrollView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        imageScrollView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        imageScrollView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
        
        coverImageView.topAnchor.constraint(
            equalTo: imageScrollView.topAnchor,
            constant: 20)
            .isActive = true
        coverImageView.leadingAnchor.constraint(
            equalTo: imageScrollView.leadingAnchor,
            constant: 20)
            .isActive = true
        coverImageView.trailingAnchor.constraint(
            equalTo: imageScrollView.trailingAnchor,
            constant: -20)
            .isActive = true
        coverImageView.bottomAnchor.constraint(
            equalTo: imageScrollView.bottomAnchor,
            constant: -20)
            .isActive = true
        coverImageView.centerYAnchor.constraint(
            equalTo: imageScrollView.centerYAnchor)
            .isActive = true
        coverImageView.centerXAnchor.constraint(
            equalTo: imageScrollView.centerXAnchor)
            .isActive = true
        
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc private func touchUpCloseButton() {
        dismiss(animated: true)
    }

}

extension ImageDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return coverImageView
    }
}
