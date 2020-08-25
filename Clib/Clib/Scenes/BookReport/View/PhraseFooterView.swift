//
//  PhraseFooterView.swift
//  Clib
//
//  Created by 이혜주 on 2020/07/21.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class PhraseFooterView: UIView {
    
    var callback: (()->())?
    
    private let addPhraseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+ 구절 추가", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
        addPhraseButton.addTarget(self,
                                  action: #selector(touchUpAddPhraseButton),
                                  for: .touchUpInside)
        
        addSubview(addPhraseButton)
        
        addPhraseButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        addPhraseButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        addPhraseButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        addPhraseButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    @objc private func touchUpAddPhraseButton() {
        callback?()
    }
}
