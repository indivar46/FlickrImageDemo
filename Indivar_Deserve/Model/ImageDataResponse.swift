//
//  ImageDataResponse.swift
//  Indivar_Deserve
//
//  Created by Indivar on 15/05/21.
//  Copyright © 2021 Indivar. All rights reserved.
//

import Foundation

//MARK: Parsing Data Received from the api
struct ImageDataResponse: Codable
{
    let photos: ImageAttributes
    let message: String?
    let stat: String?
    
    func getImages() -> [Photo]? {
        photos.photo
    }
}

struct ImageAttributes: Codable
{
    let page: Int
    let pages: Int
    let photo: [Photo]
}

struct Photo: Codable {
    let farm: Int?
    let id: String?
    let isfamily: Int?
    let isfriend: Int?
    var ispublic: Int?
    let owner: String?
    let secret: String?
    let server: String?
    let title: String?
    
    //MARK: Creating URL from various pamateres:
    func getUrl() -> String {
        let imgPath = config.imageBaseUrl + "\(farm ?? 0)" + "\(config.imageUrlExtnsn)" + "\(server ?? "")/" + "\(id ?? "")_" + "\(secret ?? "")_m.jpg"
        return imgPath
    }
}
