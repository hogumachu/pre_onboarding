//
//  ImageDownloader.swift
//  pre_onboarding
//
//  Created by 홍성준 on 2023/02/17.
//

import UIKit

final class ImageDownloader {
    
    static let shared = ImageDownloader()
    
    private init() {}
    
    func downloadImage(from imageView: UIImageView, url: URL, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: url.absoluteString)
        if let cachedImage = self.imageCache.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }
        
        let id = ObjectIdentifier(imageView)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                  let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode),
                  let data = data,
                  let image = UIImage(data: data)
            else {
                return
            }
            
            DispatchQueue.main.async {
                self.imageCache.setObject(image, forKey: cacheKey)
                completion(image)
            }
        }
        self.dataTasks[id] = dataTask
        dataTask.resume()
    }
    
    func cancelDownload(from imageView: UIImageView) {
        let id = ObjectIdentifier(imageView)
        guard let dataTask = self.dataTasks[id] else { return }
        dataTask.cancel()
        self.dataTasks[id] = nil
    }
    
    func progress(from imageView: UIImageView) -> Progress? {
        let id = ObjectIdentifier(imageView)
        guard let dataTaks = self.dataTasks[id] else { return nil }
        return dataTaks.progress
    }
    
    private var dataTasks: [ObjectIdentifier: URLSessionDataTask] = [:]
    private var imageCache = NSCache<NSString, UIImage>()
    
}
