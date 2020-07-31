//
//  EditingBookReportViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/30.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit
import CoreData

class EditingBookReportViewController: UIViewController {
    
    var row: Int?
    var bookReport: BookReport?
    var callBack: ((BookReport)->())?
    
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

        bookReportTextView.text = bookReport?.contents
        setupLayout()
    }
    
    private func setupLayout() {
        navigationItem.title = "독후감 수정"
        
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
        guard let isbn = bookReport?.isbn, let imageUrl = bookReport?.imageUrl else {
            return
        }
        
        // core data에 저장
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if let bookReportContents = bookReportTextView.text,
            let row = row {
            do {
                let bookReportEntity = try context.fetch(BookReportEntity.fetchRequest()) as! [BookReportEntity]

                let object = bookReportEntity[row]
                
                object.setValue(isbn, forKey: "isbn")
                object.setValue(bookReport?.title, forKey: "title")
                object.setValue(bookReportContents, forKey: "contents")
                object.setValue(imageUrl, forKey: "imageUrl")
            
                do {
                    try context.save()
                } catch {
                    return
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }

        bookReport?.contents = bookReportTextView.text
        callBack?(bookReport!)
        dismiss(animated: true)
    }
}
