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
        return tableView
    }()

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
        searchBar.delegate = self
    }
    
    private func setupTableView() {
        mainTableView.register(MainTableViewCell.self,
                               forCellReuseIdentifier: "mainTableViewCell")
    }
    
    private func setupLayout() {
        view.addSubview(mainTableView)
        
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
    }

}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 바뀔때마다 검색
        print(searchText)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 150
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
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
        switch section {
        case 0:
            return LogoHeaderView()
        default:
            let header = MainSectionHeaderView()
            header.titleLabel.text = sectionTitles[section - 1].rawValue
            return header
        }
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell
            = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell") as? MainTableViewCell else {
                return UITableViewCell()
        }
        
        cell.listKind = sectionTitles[indexPath.section - 1]
        
        cell.selectCallBack = { [weak self] bookData in
            let bookDetailViewController = BookDetailViewController()
            bookDetailViewController.bookData = bookData
            self?.navigationController?.pushViewController(bookDetailViewController, animated: true)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}
