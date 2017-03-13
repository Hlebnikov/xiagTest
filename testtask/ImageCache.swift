//
//  ImageCache.swift
//  testtask
//
//  Created by Александр on 10.03.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import UIKit

class ImageCache {
    static let sharedInstance = ImageCache()
    
    let cache = NSCache<NSString, UIImage>()
    
    func getImage(withKey key: String) -> UIImage?{
        return self.cache.object(forKey: key as NSString)
    }
    
    func save(image: UIImage, forKey key: String){
        self.cache.setObject(image, forKey: key as NSString)
    }
    
}
