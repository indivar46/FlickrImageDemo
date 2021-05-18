//
//  NetworkConfig.swift
//  Indivar_Deserve
//
//  Created by Indivar on 15/05/21.
//  Copyright © 2021 Indivar. All rights reserved.
//

import Foundation

//MARK: Set static key and URL
struct NetworkConfig {
    let apiKey = "2932ade8b209152a7cbb49b631c4f9b6"
    let apiurl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&per_page=100&format=json&nojsoncallback=1"
    let imageBaseUrl = "https://farm"
    let imageUrlExtnsn = ".staticflickr.com/"
}
