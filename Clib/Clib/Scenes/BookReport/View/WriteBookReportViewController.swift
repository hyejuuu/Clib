//
//  BookReportViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/31.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit
import CoreData

class WriteBookReportViewController: UIViewController {
    
    var isbn: String?
    var imageUrl: String?
    var bookTitle: String?
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let bookReportTextView: UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.font = .systemFont(ofSize: 18)
        textview.layer.borderWidth = 1.0
        textview.layer.borderColor = UIColor.lightGray.cgColor
        textview.layer.cornerRadius = 5
        return textview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    private func setupLayout() {
        navigationItem.title = "독후감 작성"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: completeButton)
        
        completeButton.addTarget(self,
                                 action: #selector(touchUpCompleteButton),
                                 for: .touchUpInside)
        
        cancelButton.addTarget(self,
                             action: #selector(touchUpCancelButton),
                             for: .touchUpInside)
        
        view.backgroundColor = .white
        
        view.addSubview(bookReportTextView)
        
        bookReportTextView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 10)
            .isActive = true
        bookReportTextView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 10)
            .isActive = true
        bookReportTextView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -10)
            .isActive = true
        bookReportTextView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -10)
            .isActive = true
    }
    
    @objc private func touchUpCancelButton() {
        dismiss(animated: true)
    }
    
    @objc private func touchUpCompleteButton() {
        guard let isbn = isbn, let imageUrl = imageUrl else {
            return
        }
        
        // core data에 저장
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "BookReport", in: context)
        
        guard bookReportTextView.text.isEmpty == false else {
            let alertController = UIAlertController(title: nil, message: "독후감 내용을 적어주세요:(", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel)
            alertController.addAction(okAction)
            present(alertController, animated: true)
            return
        }
        
        if let entity = entity, let bookReportContents = bookReportTextView.text {
            let bookreport = NSManagedObject(entity: entity, insertInto: context)
            
            bookreport.setValue(isbn, forKey: "isbn")
            bookreport.setValue(bookTitle, forKey: "title")
            bookreport.setValue(bookReportContents, forKey: "contents")
            bookreport.setValue(imageUrl, forKey: "imageUrl")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }

        
        dismiss(animated: true)
    }
}
