//
//  Network.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/24.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import Foundation

protocol Network {
    func dispatch(
        request: URLRequest,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    )
}

extension URLSession: Network {
    func dispatch(
        request: URLRequest,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(nil,
                           nil,
                           error)
                return
            }
            
            guard let data = data else {
                completion(nil,
                           nil,
                           NSError(domain: "unknown",
                                   code: 0,
                                   userInfo: nil))
                return
            }

            completion(data,
                       response,
                       nil)
        }.resume()
    }
}

class MockSession: Network {
    
    func dispatch(
        request: URLRequest,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            if let path = Bundle.main.path(forResource: "books",
                                           ofType: "json") {
                do {
                    let data
                        = try Data(contentsOf: URL(fileURLWithPath: path),
                                   options: .mappedIfSafe)

                    completion(data,
                               URLResponse(),
                               nil)
                    return
                } catch {
                    completion(nil,
                               nil,
                               NSError(domain: "unknown",
                                       code: 0,
                                       userInfo: nil))
                    return
                }
            }
        }
    }
}
