//
//  ImageFetcher.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import UIKit

let cache = NSCache<NSString, UIImage>()

extension UIImageView {
    func load(url: URL) {
        if let cachedImage = getImage(forKey: url.absoluteString) {
            UI { [weak self] in self?.image = cachedImage }
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            self?.setImage(image, key: url.absoluteString)
            
        }.resume()
    }
    
    private func setImage(_ image: UIImage, key: String) {
        cache.setObject(image, forKey: .init(string: key))
        UI { [weak self] in self?.image = image }
    }
    
    private func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: .init(string: key))
    }
}

