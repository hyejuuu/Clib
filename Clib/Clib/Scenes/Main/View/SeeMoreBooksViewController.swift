//
//  SeeMoreBooksViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/06/24.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class SeeMoreBooksViewController: UIViewController {

    var bookListKind: BookListKind?
    private var bookList: [Book] = []
    
    private let bookService: BookServiceProtocol = BookService()
    
    private let bookListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = bookListKind?.rawValue
        requestBookList()
        setupTableView()
        setupLayout()
    }
    
    private func requestBookList() {
        switch bookListKind {
        case .bestSeller:
            bookService.fetchBestseller(maxResult: nil) { [weak self] result in
                switch result {
                case .failure(let error):
                    return
                case .success(let list):
                    self?.bookList = list.item
                    DispatchQueue.main.async {
                        self?.bookListTableView.reloadData()
                    }
                }
            }
        case .new:
            bookService.fetchNewBooks(maxResult: nil) { [weak self] result in
                switch result {
                case .failure(let error):
                    return
                case .success(let list):
                    self?.bookList = list.item
                    DispatchQueue.main.async {
                        self?.bookListTableView.reloadData()
                    }
                }
            }
        default:
            return
        }
    }
    
    private func setupTableView() {
        bookListTableView.delegate = self
        bookListTableView.dataSource = self
        bookListTableView.register(BookTableViewCell.self,
                                   forCellReuseIdentifier: "bookTableViewCell")
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(bookListTableView)
        
        bookListTableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        bookListTableView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        bookListTableView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        bookListTableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
    }

}

extension SeeMoreBooksViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 150
    }
}

extension SeeMoreBooksViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return bookList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell
            = tableView.dequeueReusableCell(withIdentifier: "bookTableViewCell")
                as? BookTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(book: bookList[indexPath.row])
        
        return cell
    }
    
    
}
