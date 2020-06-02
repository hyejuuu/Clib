//
//  String+.swift
//  Clib
//
//  Created by 이혜주 on 2020/06/02.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

extension String {
    func fetchEstimateCGRectWith(fontSize: CGFloat,
                                 width: CGFloat,
                                 weight: UIFont.Weight? = nil) -> CGRect {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let font
            = weight == nil
                ? UIFont.systemFont(ofSize: fontSize)
                : UIFont.systemFont(ofSize: fontSize, weight: weight!)
        
        return NSString(string: self)
            .boundingRect(with: size,
                          options: option,
                          attributes: [NSAttributedString.Key.font:
                            font],
                          context: nil)
    }
}
    
