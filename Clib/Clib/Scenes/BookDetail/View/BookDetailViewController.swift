//
//  BookDetailViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/31.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit
import CoreData

class BookDetailViewController: UIViewController {

    var bookData: Book?
    var itemId: String?
    
    private var starRating: Float = 0.0
    private var isUpdate: Bool = false
    private var updateObject: BookReportEntity?
    
    private let bookDetailService: BookServiceProtocol = BookService()
    private let sectionTitles = ["줄거리", "리뷰"]
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "back"),
                        for: .normal)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("공유",
                        for: .normal)
        button.setTitleColor(.black,
                             for: .normal)
        return button
    }()
    
    let detailTableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 별점 저장
        if starRating != 0.0 {
            saveStarRating(starRating)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        fetchMyStarRating()
        requestBookDetailData()
        setupLayout()
    }
    
    private func fetchMyStarRating() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext

        do {
            let bookReportEntity
                = try context?.fetch(BookReportEntity.fetchRequest())
                    as? [BookReportEntity]

            let result = bookReportEntity?.filter { $0.itemId == itemId }
            
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
    
    private func setupTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        detailTableView.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "cell")
        detailTableView.register(DetailContentsTableViewCell.self,
                                 forCellReuseIdentifier: "contentsCell")
        detailTableView.register(ButtonsTableViewCell.self,
                                 forCellReuseIdentifier: "buttonTableViewCell")
    }

    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(detailTableView)
        view.addSubview(backButton)
        view.addSubview(shareButton)
        
        shareButton.addTarget(self,
                              action: #selector(touchUpShareButton),
                              for: .touchUpInside)
        backButton.addTarget(self,
                             action: #selector(touchUpBackButton),
                             for: .touchUpInside)
        
        backButton.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        backButton.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        backButton.widthAnchor.constraint(
            equalToConstant: 50)
            .isActive = true
        backButton.heightAnchor.constraint(
            equalTo: backButton.widthAnchor)
            .isActive = true
        
        shareButton.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        shareButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        shareButton.widthAnchor.constraint(
            equalToConstant: 50)
            .isActive = true
        shareButton.heightAnchor.constraint(
            equalTo: shareButton.widthAnchor)
            .isActive = true
        
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
    }
    
    private func requestBookDetailData() {
        guard let itemId = itemId else {
            return
        }
        
        bookDetailService.fetchBookData(itemId: itemId) { [weak self] result in
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
    
    private func saveStarRating(_ score: Float) {
        guard let itemId = itemId,
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
    
    private func isOnMyList() -> Bool {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context
            = appDelegate?.persistentContainer.viewContext else {
                return false
        }
        
        do {
            let booksToReadEntity
                = try context.fetch(BooksToReadEntity.fetchRequest())
                    as? [BooksToReadEntity]
            
            return booksToReadEntity?.map { $0.itemId }
                .contains(itemId) ?? false
            
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    @objc private func touchUpShareButton() {
        guard let text = bookData?.link else {
            return
        }
        
        let activityVC
            = UIActivityViewController(activityItems: [text],
                                       applicationActivities: nil)
        
        activityVC.excludedActivityTypes = [ UIActivity.ActivityType.airDrop ]
        
        present(activityVC,
                animated: true)
    }
    
    @objc private func touchUpBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension BookDetailViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        switch indexPath.section {
        case 1:
            guard let toc = bookData?.subInfo?.toc else {
                return
            }
            
            let tocViewController = TocViewController()
            tocViewController.webString
                = "<html><body><p><font size=18>"
                + toc
                + "</font></p></body></html>"
            navigationController?.pushViewController(tocViewController,
                                                     animated: true)
        default:
            return
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        switch section {
        case 0:
            guard let bookData = bookData else {
                return UIView()
            }
            
            let header = BookDetailHeaderView()
            
            header.gestureCallBack = { [weak self] in
                let imageDetailViewController = ImageDetailViewController()
                imageDetailViewController.itemId = self?.itemId
                imageDetailViewController.modalPresentationStyle = .fullScreen
                self?.present(imageDetailViewController,
                              animated: true)
            }
            
            header.rating = starRating
            
            header.ratingCallback = { [weak self] score in
                self?.starRating = score
            }
            
            header.configure(book: bookData)
            return header
        case 2, 3:
            let header = MainSectionHeaderView()
            
            header.configure(title: sectionTitles[section - 2])
            
            return header
        default:
            return UIView()
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        switch section {
        case 0:
            guard let height
                = bookData?.title
                    .fetchEstimateCGRectWith(fontSize: 18,
                                             width: view.frame.width - 30,
                                             weight: .bold).height else {
                                                return 310
            }
            return height + 320
        case 2, 3:
            return 50
        default:
            return 0
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        case 1:
            return 50
        case 2:
            guard let text = bookData?.fullDescription else {
                return 0
            }
            return text.fetchEstimateCGRectWith(fontSize: 18,
                                                width: tableView.frame.width - 40)
                .height
        default:
            return 0
        }
    }
}

extension BookDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch section {
        case 1:
            guard let toc = bookData?.subInfo?.toc,
                toc.isEmpty == false else {
                return 0
            }
            return 1
        case 0, 2, 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell
                = tableView.dequeueReusableCell(withIdentifier: "buttonTableViewCell")
                    as? ButtonsTableViewCell,
                let itemId = bookData?.itemId else {
                return UITableViewCell()
            }

            cell.configure(isOnMyList())
            
            cell.writeCallBack = { [weak self] in

                guard let bookData = self?.bookData else {
                    return
                }
                
                let alertController
                    = UIAlertController(title: "작성하고자 하는 유형을 선택해주세요",
                                        message: nil,
                                        preferredStyle: .actionSheet)
                
                let reviewAction = UIAlertAction(title: "명언 작성",
                                                 style: .default) { [weak self] _ in
                    let phraseViewController = WritePhraseViewController()
                    phraseViewController.itemId = String(bookData.itemId)
                    phraseViewController.bookTitle = self?.bookData?.title
                    phraseViewController.imageUrl = self?.bookData?.cover
                    let phraseNavigator
                        = UINavigationController(rootViewController: phraseViewController)
                    phraseNavigator.modalPresentationStyle = .fullScreen
                    self?.present(phraseNavigator,
                                  animated: true)
                }
                
                let reportAction = UIAlertAction(title: "독후감 작성",
                                                 style: .default) { [weak self] _ in
                    let bookReportViewController = WriteBookReportViewController()
                    bookReportViewController.itemId = String(bookData.itemId)
                    bookReportViewController.bookTitle = self?.bookData?.title
                    bookReportViewController.imageUrl = self?.bookData?.cover
                    
                    let bookReportNavigator
                        = UINavigationController(rootViewController: bookReportViewController)
                    bookReportNavigator.modalPresentationStyle = .fullScreen
                    self?.present(bookReportNavigator,
                                  animated: true)
                    
                }
                let cancelAction = UIAlertAction(title: "취소",
                                                 style: .cancel)
                alertController.addAction(reviewAction)
                alertController.addAction(reportAction)
                alertController.addAction(cancelAction)
                
                self?.present(alertController,
                              animated: true)
            }
            
            cell.bookMarkCallBack = { [weak self] isSave in

                if isSave {
                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    guard let context
                        = appDelegate?.persistentContainer.viewContext else {
                            return
                    }
                
                    let entity
                        = NSEntityDescription.entity(forEntityName: "BooksToRead",
                                                     in: context)
                
                    if let entity = entity {
                        let bookreport = NSManagedObject(entity: entity,
                                                         insertInto: context)
                        
                        bookreport.setValue(self?.itemId,
                                            forKey: "itemId")
                        
                        do {
                            try context.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } else {
                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    guard let context
                        = appDelegate?.persistentContainer.viewContext else {
                            return
                    }
                
                    do {
                        let booksToReadEntity
                            = try context.fetch(BooksToReadEntity.fetchRequest())
                                as? [BooksToReadEntity]
                        
                        let result
                            = booksToReadEntity?.filter { $0.itemId == self?.itemId }
                        
                        guard let object = result?.first else {
                            return
                        }
                        
                        context.delete(object)
                        
                        do {
                            try context.save()
                        } catch {
                            return
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            cell.itemId = String(itemId)
            cell.selectionStyle = .none
            
            return cell
        case 1:
            guard let cell
                = tableView.dequeueReusableCell(withIdentifier: "cell") else {
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
            cell.webString
                = "<html><body><p><font size=18>"
                + description
                + "</font></p></body></html>"
            
            return cell
        default:
            guard let cell
                = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
    }
}
