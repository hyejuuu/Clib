//
//  TabBarViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/29.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit
import CoreData

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().barTintColor = .white
        
        checkExistUser()
        setupLayout()
        makeViewControllers()
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.1991617382, green: 0.247386992, blue: 0.3030927181, alpha: 1)
    }
    
    private func checkExistUser() {
        // uid가 있는지 확인하고 nil이면 nickNameSignUpViewController 띄우기
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    private func makeViewControllers() {
        let mainViewController = MainViewController()
        mainViewController.tabBarItem = UITabBarItem(title: "메인",
                                                     image: UIImage(),
                                                     tag: 0)
        
        let mainNavigationController
            = UINavigationController(rootViewController: mainViewController)
        
        let bookReportListViewController = BookReportListViewController()
        bookReportListViewController.tabBarItem = UITabBarItem(title: "내 서재",
                                                     image: UIImage(),
                                                     tag: 0)
        
        let bookReportNavigationController
            = UINavigationController(rootViewController: bookReportListViewController)
        
        let phraseListViewController = PhraseListViewController()
        phraseListViewController.tabBarItem = UITabBarItem(title: "내 명언",
                                                     image: UIImage(),
                                                     tag: 0)
        
        let phraseNavigationController
            = UINavigationController(rootViewController: phraseListViewController)
        
        let myPageListViewController = MyPageViewController()
        myPageListViewController.tabBarItem = UITabBarItem(title: "마이페이지",
                                                     image: UIImage(),
                                                     tag: 0)
        
        let myPageNavigationController
            = UINavigationController(rootViewController: myPageListViewController)
        
        
        let viewControllers = [mainNavigationController,
                               bookReportNavigationController,
                               phraseNavigationController,
                               myPageNavigationController]
        
        setViewControllers(viewControllers, animated: false)
        
    }

}
