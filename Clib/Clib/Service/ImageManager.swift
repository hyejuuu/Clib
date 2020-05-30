//
//  ImageManager.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/24.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import UIKit

class ImageManager: ImageManagerProtocol {
    
    private let cache = NSCache<NSString, UIImage>()
    private let network: Network = URLSession.shared
    
    private func downloadImage(urlString: String,
                       completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "urlFailure", code: 0, userInfo: nil)))
            return
        }
        
        let request = URLRequest(url: url)
        
        network.dispatch(request: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                let image = UIImage(data: data) else {
                completion(.failure(NSError(domain: "unknown", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(image))
        }
    }
    
    private func storeImageToCache(urlString: String, image: UIImage) {
        cache.setObject(image, forKey: urlString as NSString)
    }
    
    func fetchImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = cache.object(forKey: urlString as NSString) {
            completion(.success(image))
            return
        } else {
            downloadImage(urlString: urlString) { [weak self] result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                    return
                case .success(let image):
                    self?.storeImageToCache(urlString: urlString, image: image)
                    
                    completion(.success(image))
                }
            }
        }
    }
    
    static func == (lhs: ImageManager, rhs: ImageManager) -> Bool {
        return true
    }
}
