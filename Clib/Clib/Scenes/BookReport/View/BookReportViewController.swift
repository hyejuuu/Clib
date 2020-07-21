//
//  BookReportViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/31.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit
import CoreData

class BookReportViewController: UIViewController {
    
    var isbn: String?
    var phrases: [Phrase]?
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: completeButton)
        
        completeButton.addTarget(self,
                                 action: #selector(touchUpCompleteButton),
                                 for: .touchUpInside)
        
        backButton.addTarget(self,
                             action: #selector(touchUpBackButton),
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
    
    @objc private func touchUpBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func touchUpCompleteButton() {
        // core data에 저장
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if let phrases = phrases {

            let phraseEntity = NSEntityDescription.entity(forEntityName: "Phrase", in: context)
            
            if let phraseEntity = phraseEntity {
                
                phrases.forEach {
                    let phrase = NSManagedObject(entity: phraseEntity, insertInto: context)
                    
                    phrase.setValue(isbn, forKey: "isbn")
                    phrase.setValue($0.page, forKey: "page")
                    phrase.setValue($0.contents, forKey: "contents")

                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            }
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "BookReport", in: context)
        
        if let entity = entity {
            let bookreport = NSManagedObject(entity: entity, insertInto: context)
            
            bookreport.setValue(isbn, forKey: "isbn")
            bookreport.setValue(bookReportTextView.text, forKey: "contents")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }

        
        dismiss(animated: true)
    }
}
