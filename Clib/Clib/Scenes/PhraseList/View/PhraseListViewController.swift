//
//  PhraseListViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/25.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class PhraseListViewController: UIViewController {

    var phrases: [Phrase] = []
    
    private let phraseListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        
        phrases = []
        fetchPhraseData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupLayout()
    }
    
    private func fetchPhraseData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        do {
            let phrase = try context.fetch(PhraseEntity.fetchRequest()) as! [PhraseEntity]
            
            phrase.forEach {
                phrases.append(Phrase(itemId: $0.itemId,
                                      page: $0.page,
                                      contents: $0.contents,
                                      imageUrl: $0.imageUrl))
            }
            
            phraseListTableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setupTableView() {
        phraseListTableView.delegate = self
        phraseListTableView.dataSource = self
        
        phraseListTableView.register(PhraseTableViewCell.self,
                                     forCellReuseIdentifier: "phraseCell")
    }
    
    private func setupLayout() {
        navigationItem.title = "내 명언"
        
        view.addSubview(phraseListTableView)
        
        phraseListTableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        phraseListTableView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        phraseListTableView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        phraseListTableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
    }
}

extension PhraseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let phraseViewController = PhraseViewController()
        phraseViewController.phrase = phrases[indexPath.row]
        phraseViewController.row = indexPath.row
        navigationController?.pushViewController(phraseViewController,
                                                 animated: true)
    }
}

extension PhraseListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phrases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "phraseCell") as? PhraseTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(phrases[indexPath.row])
        return cell
    }
}
