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
    var isbn: String?
    
    private let sectionTitles = ["줄거리", "리뷰"]
    
    let bottomButtonItemsView: BottomButtonItemsView = {
        let view = BottomButtonItemsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let detailTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true

        bottomButtonItemsView.writeReviewCallBack = { [weak self] in
            
        }
        bottomButtonItemsView.writeBookReportCallBack = { [weak self] in
            let bookReportViewController = BookReportViewController()
            bookReportViewController.modalPresentationStyle = .fullScreen
            self?.present(bookReportViewController, animated: true)
        }
        bottomButtonItemsView.moveToSiteCallBack = { [weak self] in
            
        }
        
        setupTableView()
        requestBookDetailData()
        setupLayout()
    }
    
    private func setupTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        detailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        detailTableView.register(DetailContentsTableViewCell.self, forCellReuseIdentifier: "contentsCell")
    }

    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(detailTableView)
        view.addSubview(bottomButtonItemsView)
        
        detailTableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        detailTableView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        detailTableView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        detailTableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
        
        bottomButtonItemsView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
        bottomButtonItemsView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        bottomButtonItemsView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        bottomButtonItemsView.heightAnchor.constraint(
            equalToConstant: 70)
            .isActive = true
    }
    
    private func requestBookDetailData() {
        guard let isbn = isbn else { return }
        bookDetailService.fetchBookData(isbn: isbn) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                return
            case .success(let bookData):
                self?.bookData = bookData
                
                DispatchQueue.main.async {
                    self?.detailTableView.reloadData()
                }
            }
        }
    }
}

extension BookDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            guard let toc = bookData?.subInfo?.toc else { return }
            let tocViewController = TocViewController()
            tocViewController.webString = "<html><body><p><font size=18>" + toc + "</font></p></body></html>"
            navigationController?.pushViewController(tocViewController, animated: true)
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            guard let bookData = bookData else { return UIView() }
            
            let header = BookDetailHeaderView()
            header.titleLabel.text = bookData.title
            header.authorLabel.text = bookData.author
            header.setImage(urlString: bookData.cover)
            return header
        case 2, 3:
            let header = MainSectionHeaderView()
            header.configure(title: sectionTitles[section - 2])
            return header
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 190
        case 2, 3:
            return 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 50
        case 2:
            guard let text = bookData?.fullDescription else { return 0 }
            return text.fetchEstimateCGRectWith(fontSize: 18, width: tableView.frame.width - 40).height
        default:
            return 0
        }
    }
}

extension BookDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            guard let toc = bookData?.subInfo?.toc,
                toc.isEmpty == false else {
                return 0
            }
            return 1
        case 2, 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.textLabel?.text = "목차 >"
            
            return cell
        case 2:
            guard let cell
                = tableView.dequeueReusableCell(withIdentifier: "contentsCell")
                    as? DetailContentsTableViewCell,
                let description = bookData?.fullDescription else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.webString = "<html><body><p><font size=18>" + description + "</font></p></body></html>"
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
    }
}
