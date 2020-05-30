//
//  TabBarViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/29.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().barTintColor = .white
        
        setupLayout()
        makeViewControllers()
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.1991617382, green: 0.247386992, blue: 0.3030927181, alpha: 1)
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
        
        let bookReportViewController = BookReportViewController()
        bookReportViewController.tabBarItem = UITabBarItem(title: "내 서재",
                                                     image: UIImage(),
                                                     tag: 0)
        
        let bookReportNavigationController
            = UINavigationController(rootViewController: bookReportViewController)
        
        let viewControllers = [mainNavigationController,
                               bookReportNavigationController]
        
        setViewControllers(viewControllers, animated: false)
        
    }

}
