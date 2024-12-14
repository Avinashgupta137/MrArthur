//
//  ImageCaching.swift
//  MrArthur
//
//  Created by BAPS on 18/01/23.
//

import Foundation
import SwiftUI

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    init() {
        self.cache.countLimit = 100 //(100 images)
        self.cache.totalCostLimit = 100 * 1024 * 1024 //(100 MB)
    }
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
