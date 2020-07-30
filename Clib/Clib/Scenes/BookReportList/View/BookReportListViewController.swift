//
//  BookReportListViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/06/01.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

struct BookReport {
    var isbn: String?
    var title: String?
    var rate: Float?
    var contents: String?
}

class BookReportListViewController: UIViewController {
    
    private var bookReports: [BookReport] = []
    
    private let bookReportTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        fetchBookReportData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupLayout()
    }
    
    private func fetchBookReportData() {
        
        bookReports = []

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        do {
            let bookReport = try context.fetch(BookReportEntity.fetchRequest()) as! [BookReportEntity]
            
            bookReport.forEach {
                bookReports.append(BookReport(isbn: $0.isbn,
                                              title: $0.title,
                                              rate: $0.rate,
                                              contents: $0.contents))
            }
            
            bookReportTableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setupTableView() {
        bookReportTableView.delegate = self
        bookReportTableView.dataSource = self
        
        bookReportTableView.register(BookReportTableViewCell.self,
                                     forCellReuseIdentifier: "bookReportCell")
    }
    
    private func setupLayout() {
        navigationItem.title = "내 서재"
        
        view.addSubview(bookReportTableView)
        
        bookReportTableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        bookReportTableView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        bookReportTableView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        bookReportTableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
    }

}

extension BookReportListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookReportViewController = BookReportViewController()
        bookReportViewController.isbn = bookReports[indexPath.row].isbn
        bookReportViewController.contents = bookReports[indexPath.row].contents
        bookReportViewController.row = indexPath.row
        navigationController?.pushViewController(bookReportViewController, animated: true)
    }
}

extension BookReportListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookReports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookReportCell") as? BookReportTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(bookReports[indexPath.row])
        
        return cell
    }
}
