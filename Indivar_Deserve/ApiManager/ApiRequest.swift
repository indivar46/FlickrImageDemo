//
//  ApiRequest.swift
//  Indivar_Deserve
//
//  Created by Indivar on 15/05/21.
//  Copyright © 2021 Indivar. All rights reserved.
//

import Foundation

var config = NetworkConfig()

//MARK: Api Request to Server
struct ApiRequest {
    
    func fetchImages(request: SearchRequest,completionHandler: @escaping (ImageDataResponse?) -> ()) {
        let urlRequest = generateLoginUrlRequest(request: request)
        print(urlRequest)
        URLSession.shared.dataTask(with: urlRequest)  { (data, response, error) in 
            if(error == nil && data != nil)
            {
                do {
                    let result = try JSONDecoder().decode(ImageDataResponse.self, from: data!)
                    completionHandler(result)
                } catch let error {
                    
                    completionHandler(error as? ImageDataResponse)
                    debugPrint(error)
                }
            }
            
        }.resume()
        
    }
    
    private func generateLoginUrlRequest(request: SearchRequest) -> URLRequest{
        let urlRequest = URLRequest(url: URL(string: "\(config.apiurl)&api_key=\(config.apiKey)&tags=\(request.searchText)&page=\(request.pageNo)")!)
        return urlRequest
    }
    
    
}

