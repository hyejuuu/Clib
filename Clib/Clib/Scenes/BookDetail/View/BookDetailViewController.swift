//
//  BookDetailViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/31.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    private let bookDetailService: BookServiceProtocol = BookService()
    var bookData: Book?
    
    let detailTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestBookDetailData()
        setupLayout()
    }

    private func setupLayout() {
        view.backgroundColor = .white
    }
    
    private func requestBookDetailData() {
        guard let isbn = bookData?.isbn13 else { return }
        bookDetailService.fetchBookData(isbn: isbn) { result in
            switch result {
            case .failure(let error):
                print(error)
                return
            case .success(let bookData):
                print(bookData)
            }
        }
    }
}
