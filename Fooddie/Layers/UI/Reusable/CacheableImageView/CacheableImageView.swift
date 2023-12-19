//
//  CacheableImageView.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import UIKit

final class CacheableImageView: UIImageView {
  
  private let imageCache = NSCache<NSString, AnyObject>()
  
  private let activityIndicator = UIActivityIndicatorView()
  
  private func downloadImageFrom(
    urlString: String,
    imageMode: UIView.ContentMode
  ) {
    guard let url = URL(string: urlString) else { return }
    downloadImageFrom(url: url, imageMode: imageMode)
  }
  
  internal func setUpLoader() {
    activityIndicator.center = center
    activityIndicator.hidesWhenStopped = true
    addSubview(activityIndicator)
    self.activityIndicator.startAnimating()
  }
  
  internal func downloadImageFrom(
    url: URL,
    imageMode: UIView.ContentMode
  ) {
    contentMode = imageMode
    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
      self.image = cachedImage
    } else {
      URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else { return }
        DispatchQueue.main.async {
          let imageToCache = UIImage(data: data)?.resizeImage(with: CGSize(width: 101.0, height: 101.0))
          self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
          self.image = imageToCache
          self.activityIndicator.stopAnimating()
        }
      }.resume()
    }
  }
}

