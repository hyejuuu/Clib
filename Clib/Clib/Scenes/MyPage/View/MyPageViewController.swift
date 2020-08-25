//
//  MyPageViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/08/03.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    private let myPageTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.tableFooterView = UIView()
        return tableview
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupLayout()
    }
    
    private func setupTableView() {
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
        
        myPageTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupLayout() {
        navigationItem.title = "마이페이지"
        
        view.addSubview(myPageTableView)
        
        myPageTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        myPageTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myPageTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        myPageTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(SavedBookViewController(),
                                                     animated: true)
        default:
            return
        }
    }
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "저장한 책"
        cell.selectionStyle = .none
        return cell
    }
}
