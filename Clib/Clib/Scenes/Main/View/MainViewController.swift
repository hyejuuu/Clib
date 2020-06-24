//
//  MainViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/25.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let sectionTitles = BookListKind.allCases
    let bookService: BookServiceProtocol = BookService()
    var searchedBookList: [Book] = []
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    private let mainTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        return tableView
    }()
    
    private let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.alpha = 0
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchBar

        setupDelegateAndDataSource()
        setupTableView()
        setupLayout()
    }
    
    private func setupDelegateAndDataSource() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
    }
    
    private func setupTableView() {
        mainTableView.register(MainTableViewCell.self,
                               forCellReuseIdentifier: "mainTableViewCell")
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupLayout() {
        view.addSubview(mainTableView)
        view.addSubview(searchTableView)
        
        mainTableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        mainTableView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        mainTableView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        mainTableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
        
        searchTableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        searchTableView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        searchTableView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        searchTableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
    }

    @objc private func requestBookData() {
        guard let text = searchBar.text else { return }
        bookService.fetchSearchedBookList(searchString: text) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                return
            case .success(let list):
                self?.searchedBookList = list.item
                DispatchQueue.main.async {
                    self?.searchTableView.reloadData()
                }
            }
        }
    }
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(requestBookData), object: nil)
        self.perform(#selector(requestBookData), with: nil, afterDelay: 0.5)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchTableView.alpha = 1
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchTableView.alpha = 0
        searchedBookList = []
        searchTableView.reloadData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView == searchTableView else { return }
        
        let bookDetailViewController = BookDetailViewController()
        bookDetailViewController.isbn = searchedBookList[indexPath.row].isbn13
        navigationController?.pushViewController(bookDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == searchTableView {
            return 0
        }
        
        switch section {
        case 0:
            return 170
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == searchTableView {
            return 50
        }
        
        switch indexPath.section {
        case 0:
            return 0
        default:
            return 230
        }
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == searchTableView {
            return UIView()
        }
        
        switch section {
        case 0:
            return LogoHeaderView()
        default:
            let header = MainSectionHeaderView()
            header.configure(title: sectionTitles[section - 1].rawValue)
            header.callback = { [weak self] in
                // 더보기
                let seeMoreBooksViewController = SeeMoreBooksViewController()
                if section == 1 {
                    seeMoreBooksViewController.bookListKind = .bestSeller
                } else if section == 2 {
                    seeMoreBooksViewController.bookListKind = .new
                }
                self?.navigationController?.pushViewController(seeMoreBooksViewController, animated: true)
            }
            return header
        }
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if tableView == searchTableView {
            return searchedBookList.count
        }
        
        switch section {
        case 0:
            return 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell()
            }
            
            cell.textLabel?.text = searchedBookList[indexPath.row].title
            
            return cell
        }
        
        guard let cell
            = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell") as? MainTableViewCell else {
                return UITableViewCell()
        }
        
        cell.listKind = sectionTitles[indexPath.section - 1]
        
        cell.selectCallBack = { [weak self] bookData in
            let bookDetailViewController = BookDetailViewController()
            bookDetailViewController.isbn = bookData.isbn13
            self?.navigationController?.pushViewController(bookDetailViewController, animated: true)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == searchTableView {
            return 1
        }
        return 3
    }
}
