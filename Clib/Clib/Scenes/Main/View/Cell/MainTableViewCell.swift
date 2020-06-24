//
//  MainTableViewCell.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/25.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

enum BookListKind: String, CaseIterable {
    case bestSeller = "베스트셀러"
    case new = "신간"
}

class MainTableViewCell: UITableViewCell {
    
    private let bookService: BookServiceProtocol = BookService()
    var listKind: BookListKind? {
        didSet {
            requestBookList()
        }
    }
    var selectCallBack: ((Book)->())?
    
    var bookList: [Book] = []
    
    let sectionMenuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupDelegateAndDataSource()
        setupCollectionView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDelegateAndDataSource() {
        sectionMenuCollectionView.delegate = self
        sectionMenuCollectionView.dataSource = self
    }
    
    private func setupCollectionView() {
        sectionMenuCollectionView.register(BookCollectionViewCell.self,
                                           forCellWithReuseIdentifier: "bookCollectionViewCell")
    }
    
    private func requestBookList() {
        switch listKind {
        case .bestSeller:
            bookService.fetchBestseller(maxResult: 8) { [weak self] result in
                switch result {
                case .failure(let error):
                    return
                case .success(let list):
                    self?.bookList = list.item
                    DispatchQueue.main.async {
                        self?.sectionMenuCollectionView.reloadData()
                    }
                }
            }
        case .new:
            bookService.fetchNewBooks(maxResult: 8) { [weak self] result in
                switch result {
                case .failure(let error):
                    return
                case .success(let list):
                    self?.bookList = list.item
                    DispatchQueue.main.async {
                        self?.sectionMenuCollectionView.reloadData()
                    }
                }
            }
        case .none:
            break
        }
    }
    
    private func setupLayout() {
        contentView.addSubview(sectionMenuCollectionView)
        
        sectionMenuCollectionView.topAnchor.constraint(
            equalTo: contentView.topAnchor)
            .isActive = true
        sectionMenuCollectionView.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor)
            .isActive = true
        sectionMenuCollectionView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor)
            .isActive = true
        sectionMenuCollectionView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor)
            .isActive = true
    }
    
}

extension MainTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

extension MainTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        selectCallBack?(bookList[indexPath.item])
    }
}

extension MainTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCollectionViewCell", for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(book: bookList[indexPath.item])
        
        return cell
    }
}
