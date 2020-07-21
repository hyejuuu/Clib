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
//        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        
//        let request: NSFetchRequest<NSFetchRequestResult> = PhraseEntity.fetchRequest()
//        let delete = NSBatchDeleteRequest(fetchRequest: request)
//        
//        do {
//            try context.execute(delete)
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        
//        let request2: NSFetchRequest<NSFetchRequestResult> = BookReportEntity.fetchRequest()
//        let delete2 = NSBatchDeleteRequest(fetchRequest: request2)
//        
//        do {
//            try context.execute(delete2)
//        } catch {
//            print(error.localizedDescription)
//        }
        
//
//        do {
//            let bookReport = try context.fetch(PhraseEntity.fetchRequest()) as! [PhraseEntity]
//            bookReport.forEach {
//                print($0.page)
//                print($0.contents)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }

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
        
        let viewControllers = [mainNavigationController,
                               bookReportNavigationController]
        
        setViewControllers(viewControllers, animated: false)
        
    }

}
