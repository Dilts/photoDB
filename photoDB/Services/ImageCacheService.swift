//
//  ImageCacheService.swift
//  photoDB
//
//  Created by Brian Dilts on 5/24/21.
//

import Foundation
import UIKit

class ImageCacheService {
    
    static var imageCache = [String:UIImage]()
    
    static func saveImage(url:String?, image:UIImage?) {
        
        // Check against nil
        if url == nil || image == nil {
            return
        }
        
        // Save the image
        imageCache[url!] = image!
    }
    
    static func getImage(url:String?) -> UIImage? {
        
        // Check that url isn't nil
        if url == nil {
            return nil
        }
        
        // Check the image cache for the url
        return imageCache[url!]
        
    }
    
    
}
