//
//  BookDetailViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/31.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookData: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    private func setupLayout() {
        view.backgroundColor = .white
        
        print(bookData)
    }
}
