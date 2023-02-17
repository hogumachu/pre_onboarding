//
//  UIImageView+.swift
//  pre_onboarding
//
//  Created by 홍성준 on 2023/02/17.
//

import UIKit

extension UIImageView {
    
    var progress: Progress? {
        ImageDownloader.shared.progress(from: self)
    }
    
    func setImage(url: String?) {
        guard let urlString = url,
              let url = URL(string: urlString)
        else {
            return
        }
        
        ImageDownloader.shared.downloadImage(from: self, url: url) { [weak self] image in
            self?.image = image
        }
    }
    
    func cancelDownloadImage() {
        ImageDownloader.shared.cancelDownload(from: self)
    }
    
}
