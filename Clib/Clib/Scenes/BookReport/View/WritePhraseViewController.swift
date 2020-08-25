//
//  PhraseViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/21.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit
import CoreData

class WritePhraseViewController: UIViewController {
    
    var bookTitle: String?
    var itemId: String?
    var imageUrl: String?
    var phrases: [Phrase] = []
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("완료",
                        for: .normal)
        button.setTitleColor(.black,
                             for: .normal)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소",
                        for: .normal)
        button.setTitleColor(.black,
                             for: .normal)
        return button
    }()
    
    private let phrasesTableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupLayout()
    }
    
    private func setupTableView() {
        phrasesTableView.delegate = self
        phrasesTableView.dataSource = self
        
        phrasesTableView.register(WritePhraseTableViewCell.self,
                                  forCellReuseIdentifier: "phraseCell")
    }
    
    private func setupLayout() {
        navigationItem.title = "기억에 남는 구절"
        
        navigationItem.leftBarButtonItem
            = UIBarButtonItem(customView: cancelButton)
        navigationItem.rightBarButtonItem
            = UIBarButtonItem(customView: nextButton)
        
        cancelButton.addTarget(self,
                              action: #selector(touchUpCloseButton),
                              for: .touchUpInside)
        
        nextButton.addTarget(self,
                              action: #selector(touchUpNextButton),
                              for: .touchUpInside)
        
        view.backgroundColor = .white
        
        view.addSubview(phrasesTableView)
        
        phrasesTableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        phrasesTableView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        phrasesTableView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        phrasesTableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
        
    }

    @objc private func touchUpCloseButton() {
        dismiss(animated: true)
    }
    
    @objc private func touchUpNextButton() {
        guard phrases.count != 0
            && phrases.last?.page != nil
            && phrases.last?.contents != nil else {
            let alertController
                = UIAlertController(title: nil,
                                    message: "페이지와 명언을 모두 채워주세요:(",
                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인",
                                         style: .cancel)
            alertController.addAction(okAction)
            present(alertController,
                    animated: true)
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let phraseEntity = NSEntityDescription.entity(forEntityName: "Phrase",
                                                      in: context)
        
        if let phraseEntity = phraseEntity {
            
            phrases.forEach {
                if let page = $0.page,
                    let contents = $0.contents {
                    let phrase = NSManagedObject(entity: phraseEntity,
                                                 insertInto: context)
                    
                    phrase.setValue(itemId,
                                    forKey: "itemId")
                    phrase.setValue(page,
                                    forKey: "page")
                    phrase.setValue(contents,
                                    forKey: "contents")
                    phrase.setValue(imageUrl,
                                    forKey: "imageUrl")

                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
        }
        
        dismiss(animated: true)
    }

}

extension WritePhraseViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return PhraseHeaderView()
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        let footerView = PhraseFooterView()
        footerView.callback = { [weak self] in
            
            if let last = self?.phrases.last {
                if last.page == nil,
                    last.contents == nil {
                    let alertController
                        = UIAlertController(title: "알림",
                                            message: "구절을 모두 채우고 추가해주세요:)",
                                            preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인",
                                                 style: .cancel)
                    alertController.addAction(okAction)
                    self?.present(alertController,
                                  animated: true)
                    return
                }
            }
            
            self?.phrases.append(Phrase())
            self?.phrasesTableView.reloadData()
        }
        return footerView
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 100
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 260
    }
}

extension WritePhraseViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return phrases.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell
            = tableView.dequeueReusableCell(withIdentifier: "phraseCell")
                as? WritePhraseTableViewCell else {
            return UITableViewCell()
        }
        
        cell.deleteCallback = { [weak self] in
            self?.phrases.remove(at: indexPath.row)
            self?.phrasesTableView.deleteRows(at: [indexPath],
                                              with: .automatic)
        }
        
        cell.pageSaveCallback = { [weak self] page in
            self?.phrases[indexPath.row].page = page
        }
        
        cell.contentsSaveCallback = { [weak self] contents in
            self?.phrases[indexPath.row].contents = contents
        }
        
        return cell
    }
    
}
