//
//  SavedBookViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/08/03.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

struct BooksToRead {
    let itemId: String?
}

class SavedBookViewController: UIViewController {

    private let bookDetailService: BookServiceProtocol = BookService()
    private var savedBooks: [Book] = []
    
    private let savedBookTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.tableFooterView = UIView()
        return tableview
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        
        fetchSavedBookData(fetchSavedBookItemId())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupLayout()
    }
    
    private func fetchSavedBookItemId() -> [String]? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        do {
            let booksToReadEntity
                = try context.fetch(BooksToReadEntity.fetchRequest())
                    as? [BooksToReadEntity]

            return booksToReadEntity?.map { ($0.itemId ?? "") }
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    private func fetchSavedBookData(
        _ itemIds: [String]?
    ) {
        guard let itemIds = itemIds else { return }
        
        savedBooks = []
        
        guard itemIds.isEmpty == false else {
            savedBookTableView.reloadData()
            return
        }
        
        itemIds.forEach {
            bookDetailService.fetchBookData(itemId: $0) { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                    return
                case .success(let bookData):
                    self?.savedBooks.append(bookData)
                    
                    DispatchQueue.main.async {
                        self?.savedBookTableView.reloadData()
                    }
                }
            }
        }
    }
    
    private func setupTableView() {
        savedBookTableView.delegate = self
        savedBookTableView.dataSource = self
        
        savedBookTableView.register(UITableViewCell.self,
                                    forCellReuseIdentifier: "cell")
    }
    
    private func setupLayout() {
        navigationItem.title = "내가 저장한 책"
        
        view.addSubview(savedBookTableView)
        
        savedBookTableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        savedBookTableView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        savedBookTableView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        savedBookTableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
    }

}

extension SavedBookViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let bookDetailViewController = BookDetailViewController()
        bookDetailViewController.itemId
            = String(savedBooks[indexPath.row].itemId)
        navigationController?.pushViewController(bookDetailViewController,
                                                 animated: true)
    }
}

extension SavedBookViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return savedBooks.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell
            = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "\(savedBooks[indexPath.row].title)"
        
        return cell
    }
}
