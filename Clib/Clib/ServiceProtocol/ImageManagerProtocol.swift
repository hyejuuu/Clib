//
//  ImageManagerProtocol.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/24.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

protocol ImageManagerProtocol {
    func fetchImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}
