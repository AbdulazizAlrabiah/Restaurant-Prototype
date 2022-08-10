//
//  RestaurantsDetailViewModel.swift
//  
//
//  Created by Abdulaziz on 09/08/2022.
//

import UIKit

class RestaurantsDetailViewModel {
    
    func resizeImageIfLargerThan(image: UIImage?, largerThan targetSize: CGSize) -> UIImage? {
        
        guard let image = image else {
            return nil
        }
        
        if (image.size.height <= targetSize.height && image.size.width <= targetSize.width) {
            return image
        }

        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        
        if (widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
