//
//  CustomImageView.swift
//  NY Times
//
//  Created by Ghulam Murtaza on 12/07/2024.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {

    // MARK: - Properties
    private var imageURLString: String?
    private var apiHander:APIManagerInterface
    private var cacheImage:CacheImagesInterface
    
    init(apiHander:APIManagerInterface,
         cacheImage:CacheImagesInterface) {
        
        self.apiHander = apiHander
        self.cacheImage = cacheImage
        super.init(image: nil, highlightedImage: nil)
    }
    
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        self.apiHander = APIManager()
        self.cacheImage = CacheImages()
        super.init(coder: coder)
    }
    
    func downloadImageFrom(urlString: String/*, imageMode: UIView.ContentMode*/) {
        guard let url = URL(string: urlString) else { return }
        if let cachedImage = self.cacheImage.getCacheImage(url: url.absoluteString) {
            self.image = cachedImage
        } else {
            //downloadImageFrom(url: url)
            self.apiHander.downloadImageFrom(url: url) { [weak self] responseData in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    strongSelf.image = strongSelf.cacheImage.chacheimage(data: responseData, url: url)
                }
            }
        }
    }
}

protocol CacheImagesInterface {
    func chacheimage(data:Data, url:URL) -> UIImage
    func getCacheImage(url:String) -> UIImage?
}

class CacheImages:CacheImagesInterface {
    
    // MARK: - Constants
    let imageCache = NSCache<NSString, AnyObject>()
    
    func chacheimage(data:Data, url:URL) -> UIImage {
            let imageToCache = UIImage(data: data)
            self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
            //self.image = imageToCache
            return imageToCache ?? UIImage()
    }
    
    func getCacheImage(url:String) -> UIImage? {
        return imageCache.object(forKey: url as NSString) as? UIImage
    }
}
