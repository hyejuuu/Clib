//
//  BookServiceProtocol.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/24.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import Foundation

protocol BookServiceProtocol {
    func fetchBestseller(maxResult: Int?, completion: @escaping (Result<BookList, Error>) -> Void)
    func fetchNewBooks(maxResult: Int?, completion: @escaping (Result<BookList, Error>) -> Void)
    func fetchSearchedBookList(searchString: String,
                               completion: @escaping (Result<BookList, Error>) -> Void)
    func fetchBookData(isbn: String, completion: @escaping (Result<Book, Error>) -> Void)
    func fetchBookDataWithBigImage(isbn: String, completion: @escaping (Result<Book, Error>) -> Void)
}
