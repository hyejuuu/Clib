//
//  BookReportViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/23.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit
import CoreData

class BookReportViewController: UIViewController {

    var isbn: String?
    var contents: String?
    var bookData: Book?
    var row: Int?
    
    private let bookDetailService: BookServiceProtocol = BookService()
    
    private let bookReportTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private let etcButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.text = "..."
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: etcButton)

        setupTableView()
        setupLayout()
        requestBookData()
    }
    
    private func requestBookData() {
        guard let isbn = isbn else { return }
        
        bookDetailService.fetchBookData(isbn: isbn) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                return
            case .success(let bookData):
                self?.bookData = bookData
                
                DispatchQueue.main.async {
                    self?.bookReportTableView.reloadData()
                }
            }
        }
    }
    
    private func setupTableView() {
        bookReportTableView.delegate = self
        bookReportTableView.dataSource = self
        
        bookReportTableView.register(UITableViewCell.self,
                                     forCellReuseIdentifier: "BookReportCell")
    }
    
    private func setupLayout() {
        etcButton.addTarget(self,
                            action: #selector(touchUpEtcButton),
                            for: .touchUpInside)
        
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

    @objc private func touchUpEtcButton() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let edtingAction = UIAlertAction(title: "독후감 수정", style: .default) { [weak self] _ in
            
        }
        let deleteAction = UIAlertAction(title: "독후감 삭제", style: .default) { [weak self] _ in
            guard let row = self?.row else { return }
            
            // coredata에서 독후감 삭제
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            do {
                let phrase = try context.fetch(BookReportEntity.fetchRequest()) as! [BookReportEntity]
                
                context.delete(phrase[row])
                
                do {
                    try context.save()
                } catch {
                    return
                }
                
            } catch {
                print(error.localizedDescription)
            }

            // 리스트로 이동
            self?.navigationController?.popViewController(animated: true)
            
            // 리로드
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertController.addAction(edtingAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
}

extension BookReportViewController: UITableViewDelegate {
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

extension BookReportViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookReportCell") as? UITableViewCell else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = contents
        return cell
    }
    
}
