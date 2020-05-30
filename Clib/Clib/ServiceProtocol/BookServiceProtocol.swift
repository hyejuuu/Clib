//
//  BookServiceProtocol.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/24.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import Foundation

protocol BookServiceProtocol {
    func fetchBestseller(completion: @escaping (Result<BookList, Error>) -> Void)
    func fetchNewBooks(completion: @escaping (Result<BookList, Error>) -> Void)
}
