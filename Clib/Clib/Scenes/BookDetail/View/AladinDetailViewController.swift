//
//  aladinDetailViewController.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/11.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit
import WebKit

class AladinDetailViewController: UIViewController, WKUIDelegate {
    
    var webString: String? {
        didSet {
            guard let webString = self.webString else { return }
            webView.loadHTMLString(webString, baseURL: nil)
        }
    }
    
    let webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.showsVerticalScrollIndicator = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.uiDelegate = self
        navigationItem.title = "목차"
        setupLayout()
    }
    
    private func setupLayout() {
        guard let webString = webString,
            let url = URL(string: webString),
            UIApplication.shared.canOpenURL(url) else { return }

         UIApplication.shared.open(url, options: [:], completionHandler: nil)

        view.backgroundColor = .white
        
        view.addSubview(webView)
        
        webView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 20)
            .isActive = true
        webView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 20)
            .isActive = true
        webView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -20)
            .isActive = true
        webView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -20)
            .isActive = true
    }
}
