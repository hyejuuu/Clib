//
//  PhraseViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/30.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class PhraseViewController: UIViewController {
    
    var phrase: Phrase?
    var bookData: Book?
    var row: Int?
    
    private let bookDetailService: BookServiceProtocol = BookService()
    
    private let phraseTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        
        setupTableView()
        setupLayout()
        requestBookData()
    }
    
    private func requestBookData() {
        guard let isbn = phrase?.isbn else { return }
        
        bookDetailService.fetchBookData(isbn: isbn) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                return
            case .success(let bookData):
                self?.bookData = bookData
                
                DispatchQueue.main.async {
                    self?.phraseTableView.reloadData()
                }
            }
        }
    }
    
    private func setupTableView() {
        phraseTableView.delegate = self
        phraseTableView.dataSource = self
        
        phraseTableView.register(UITableViewCell.self,
                                     forCellReuseIdentifier: "PhraseCell")
    }
    
    private func setupLayout() {
        view.addSubview(phraseTableView)
        
        phraseTableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        phraseTableView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        phraseTableView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        phraseTableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView){
        // let scrollHeaderHeight = friendsTableView.sectionHeaderHeight
        let scrollHeaderHeight: CGFloat = 330
        
        if scrollView.contentOffset.y <= scrollHeaderHeight {
            if scrollView.contentOffset.y >= 0 {
                scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
            }
        } else if scrollView.contentOffset.y >= scrollHeaderHeight {
            scrollView.contentInset = UIEdgeInsets(top: -scrollHeaderHeight, left: 0, bottom: 0, right: 0)
        }
    }

}

extension PhraseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let bookData = bookData else { return UIView() }
        
        let header = BookDetailHeaderView()
        header.configure(book: bookData)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 330
    }
}

extension PhraseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhraseCell") as? UITableViewCell else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = phrase?.contents
        return cell
    }
    
}
