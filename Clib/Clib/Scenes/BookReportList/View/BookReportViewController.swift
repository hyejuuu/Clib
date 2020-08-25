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

    var bookReport: BookReport?
    var bookData: Book?
    var row: Int?
    
    private var starRating: Float = 0.0
    private var isUpdate: Bool = false
    private var updateObject: BookReportEntity?
    
    private let bookDetailService: BookServiceProtocol = BookService()
    
    private let bookReportTableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private let etcButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("...",
                        for: .normal)
        button.setTitleColor(.black,
                             for: .normal)
        return button
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // 별점 저장
        if starRating != 0.0 {
            saveStarRating(starRating)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true

        setupTableView()
        fetchMyStarRating()
        setupLayout()
        requestBookData()
    }
    
    private func fetchMyStarRating() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext

        do {
            let bookReportEntity
                = try context?.fetch(BookReportEntity.fetchRequest())
                    as? [BookReportEntity]

            let result
                = bookReportEntity?.filter { $0.itemId == bookReport?.itemId }
            
            guard let object = result?.first else {
                return
            }
            
            updateObject = object
            isUpdate = true
            starRating = object.rate

        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func requestBookData() {
        guard let itemId = bookReport?.itemId else { return }
        
        bookDetailService.fetchBookData(itemId: itemId) { [weak self] result in
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
        
        bookReportTableView.register(BookReportContentsTableViewCell.self,
                                     forCellReuseIdentifier: "BookReportCell")
    }
    
    private func setupLayout() {
        starRating = bookReport?.rate ?? 0.0
        
        navigationItem.rightBarButtonItem
            = UIBarButtonItem(customView: etcButton)
        
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
    
    private func saveStarRating(_ score: Float) {
        guard let itemId = bookReport?.itemId,
            let imageUrl = bookData?.cover else {
            return
        }
        
        // core data에 저장
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if isUpdate {
            updateObject?.setValue(itemId,
                                   forKey: "itemId")
            updateObject?.setValue(bookData?.title,
                                   forKey: "title")
            updateObject?.setValue(starRating,
                                   forKey: "rate")
            updateObject?.setValue(imageUrl,
                                   forKey: "imageUrl")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        } else {
            let entity
                = NSEntityDescription.entity(forEntityName: "BookReport",
                                             in: context)
            
            if let entity = entity,
                let bookTitle = bookData?.title {
                let bookreport = NSManagedObject(entity: entity,
                                                 insertInto: context)
                
                bookreport.setValue(itemId,
                                    forKey: "itemId")
                bookreport.setValue(bookTitle,
                                    forKey: "title")
                bookreport.setValue(starRating,
                                    forKey: "rate")
                bookreport.setValue(imageUrl,
                                    forKey: "imageUrl")
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    @objc private func touchUpEtcButton() {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        let edtingAction = UIAlertAction(title: "독후감 수정",
                                         style: .default) { [weak self] _ in
            let editingBookReportViewController = EditingBookReportViewController()
            editingBookReportViewController.row = self?.row
            editingBookReportViewController.bookReport = self?.bookReport
                                            
            editingBookReportViewController.callBack = { [weak self] bookReport in
                self?.bookReport = bookReport
                self?.bookReportTableView.reloadData()
            }
                                            
            let editingBookReportNavigatior
                = UINavigationController(rootViewController: editingBookReportViewController)
            editingBookReportNavigatior.modalPresentationStyle = .fullScreen
            self?.present(editingBookReportNavigatior,
                          animated: true)
        }
        let deleteAction = UIAlertAction(title: "독후감 삭제",
                                         style: .default) { [weak self] _ in
            guard let row = self?.row else {
                return
            }
            
            // coredata에서 독후감 삭제
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            do {
                let bookReport
                    = try context.fetch(BookReportEntity.fetchRequest())
                        as! [BookReportEntity]
                
                context.delete(bookReport[row])
                
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
        let cancelAction = UIAlertAction(title: "취소",
                                         style: .cancel)
        
        alertController.addAction(edtingAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController,
                animated: true)
    }
    
}

extension BookReportViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        guard let bookData = bookData else {
            return UIView()
        }
        
        let header = BookDetailHeaderView()
        header.rating = starRating
        
        header.gestureCallBack = { [weak self] in
            let imageDetailViewController = ImageDetailViewController()
            imageDetailViewController.itemId = String(bookData.itemId)
            imageDetailViewController.modalPresentationStyle = .fullScreen
            self?.present(imageDetailViewController,
                          animated: true)
        }
        
        header.ratingCallback = { [weak self] score in
            self?.starRating = score
        }
        
        header.configure(book: bookData)
        return header
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        guard let height
            = bookData?.title
                .fetchEstimateCGRectWith(fontSize: 18,
                                         width: view.frame.width - 30,
                                         weight: .bold).height else {
                                            return 350
        }
        return height + 350
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        if bookReport?.contents == nil {
            return 85
                + "아직 작성된 독후감이 없습니다.\n독후감을 작성해보세요 :)"
                    .fetchEstimateCGRectWith(fontSize: 15,
                                             width: view.frame.width - 40)
                    .height
        }
        guard let contentsHeight
            = bookReport?.contents?
                .fetchEstimateCGRectWith(fontSize: 15,
                                         width: view.frame.width - 40)
                .height else {
                    return 0
        }
        let height: CGFloat = 85 + contentsHeight
        return height
    }
}

extension BookReportViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 1
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell
            = tableView.dequeueReusableCell(withIdentifier: "BookReportCell")
                as? BookReportContentsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(contents: bookReport?.contents)
        
        return cell
    }
    
}
