//
//  BookService.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/24.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import Foundation
import RxSwift

class BookService: BookServiceProtocol {
    
    let network: Network = URLSession.shared
    
    func fetchBestseller(completion: @escaping (Result<BookList, Error>) -> Void) {
        guard let url = URL(string: "http://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=ttbhhhuul0980981654002&QueryType=Bestseller&MaxResults=8&start=1&SearchTarget=Book&output=js&Version=20131101") else {
            completion(.failure(NSError(domain: "unknown", code: 0, userInfo: nil)))
            return
        }
        
        let request = URLRequest(url: url)
        
        network.dispatch(request: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "unknown", code: 0, userInfo: nil)))
                return
            }
            
            guard let bookList = try? JSONDecoder().decode(BookList.self, from: data) else {
                completion(.failure(NSError(domain: "decodingFailure", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(bookList))
        }
    }
    
    func fetchNewBooks(completion: @escaping (Result<BookList, Error>) -> Void) {
        guard let url = URL(string: "http://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=ttbhhhuul0980981654002&QueryType=ItemNewSpecial&MaxResults=8&start=1&SearchTarget=Book&output=js&Version=20131101") else {
            completion(.failure(NSError(domain: "unknown", code: 0, userInfo: nil)))
            return
        }
        
        let request = URLRequest(url: url)
        
        network.dispatch(request: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "unknown", code: 0, userInfo: nil)))
                return
            }
            
            guard let bookList = try? JSONDecoder().decode(BookList.self, from: data) else {
                completion(.failure(NSError(domain: "decodingFailure", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(bookList))
        }
    }
}
