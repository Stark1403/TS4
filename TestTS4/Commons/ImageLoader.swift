//
//  ImageLoader.swift
//  TestTS4
//
//  Created by cesar.torres on 14/06/23.
//

import UIKit

class ImageLoader: UIImageView {
    let imageCache = NSCache<NSString, AnyObject>()
    var imageURLString: String?
    let activityIndicator = UIActivityIndicatorView()
    func downloadImageFrom(urlString: String, imageMode: UIView.ContentMode) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url, imageMode: imageMode)
    }
    func downloadImageFrom(url: URL, imageMode: UIView.ContentMode) {
        setupActivityIndicator()
        activityIndicator.startAnimating()
        contentMode = imageMode
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
            activityIndicator.stopAnimating()
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                    return
                }
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                    self.image = imageToCache
                    self.activityIndicator.stopAnimating()
                }
            }.resume()
        }
    }
    private func setupActivityIndicator() {
        activityIndicator.color = .darkGray
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
