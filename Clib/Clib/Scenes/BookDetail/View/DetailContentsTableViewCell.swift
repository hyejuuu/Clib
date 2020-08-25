//
//  DetailContentsTableViewCell.swift
//  Clib
//
//  Created by 이혜주 on 2020/06/02.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit
import WebKit

class DetailContentsTableViewCell: UITableViewCell {

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
        webView.isUserInteractionEnabled = false
        return webView
    }()
//
//    let contentsLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 0
//        label.font = .systemFont(ofSize: 18)
//        return label
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        webView.uiDelegate = self
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(webView)
        
        webView.topAnchor.constraint(
            equalTo: contentView.topAnchor)
            .isActive = true
        webView.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 20)
            .isActive = true
        webView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -20)
            .isActive = true
        webView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor)
            .isActive = true
    }
}

extension DetailContentsTableViewCell: WKUIDelegate {
}
