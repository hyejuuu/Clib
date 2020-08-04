//
//  EditingPhraseViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/30.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class EditingPhraseViewController: UIViewController {
    
    var row: Int?
    var phrase: Phrase?
    var callBack: ((Phrase)->())?
    
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
    
    private let pageTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.layer.borderWidth = 1.0
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.layer.cornerRadius = 5
        textfield.placeholder = "페이지"
        return textfield
    }()
    
    private let phraseTextView: UITextView = {
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

        pageTextField.text = phrase?.page
        phraseTextView.text = phrase?.contents
        setupLayout()
    }
    
    private func setupLayout() {
        navigationItem.title = "문장 수정"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: completeButton)
        
        completeButton.addTarget(self,
                                 action: #selector(touchUpCompleteButton),
                                 for: .touchUpInside)
        
        cancelButton.addTarget(self,
                             action: #selector(touchUpCancelButton),
                             for: .touchUpInside)
        
        view.backgroundColor = .white
        
        view.addSubview(pageTextField)
        view.addSubview(phraseTextView)
        
        pageTextField.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 20)
            .isActive = true
        pageTextField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 20)
            .isActive = true
        pageTextField.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -20)
            .isActive = true
        
        phraseTextView.topAnchor.constraint(
            equalTo: pageTextField.bottomAnchor,
            constant: 10)
            .isActive = true
        phraseTextView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 20)
            .isActive = true
        phraseTextView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -20)
            .isActive = true
        phraseTextView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -20)
            .isActive = true
    }
    
    @objc private func touchUpCancelButton() {
        dismiss(animated: true)
    }
    
    @objc private func touchUpCompleteButton() {
        guard let itemId = phrase?.itemId, let imageUrl = phrase?.imageUrl else {
            return
        }
        
        // core data에 저장
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if let page = pageTextField.text,
            let phraseContents = phraseTextView.text,
            let row = row {
            do {
                let phraseEntity = try context.fetch(PhraseEntity.fetchRequest()) as! [PhraseEntity]

                let object = phraseEntity[row]
                
                object.setValue(itemId, forKey: "itemId")
                object.setValue(page, forKey: "page")
                object.setValue(phraseContents, forKey: "contents")
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

        phrase?.page = pageTextField.text
        phrase?.contents = phraseTextView.text
        callBack?(phrase!)
        dismiss(animated: true)
    }
}
