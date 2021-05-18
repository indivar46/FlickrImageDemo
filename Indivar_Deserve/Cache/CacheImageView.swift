//
//  CacheImageView.swift
//  Indivar_Deserve
//
//  Created by Indivar on 16/05/21.
//  Copyright © 2021 Indivar. All rights reserved.
//

import Foundation
import UIKit

class CacheImaggeView: UIImageView
{
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    //MARK: Image Caching here

    func loadImage(fromURL imageURL: URL, placeHolderImage: String, identifier: String)
    {
        self.image = UIImage(named: placeHolderImage)
        if let cachedImage = self.imageCache.object(forKey: identifier as AnyObject)
        {
            //MARK: Load Image from cache
            //debugPrint("image loaded from cache for =\(imageURL)")
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            [weak self] in
            if let imageData = try? Data(contentsOf: imageURL)
            {
                //MARK: Download Image from Server if not in cache memory
                //debugPrint("image downloaded from server...")
                if let image = UIImage(data: imageData)
                {
                    DispatchQueue.main.async {
                        self?.imageCache.setObject(image, forKey: identifier as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
