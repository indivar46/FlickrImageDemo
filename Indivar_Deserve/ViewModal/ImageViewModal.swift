//
//  ImageViewModal.swift
//  Indivar_Deserve
//
//  Created by Amit on 26/05/21.
//  Copyright © 2021 Indivar. All rights reserved.
//

import Foundation
//MARK: Protocol for Api response
protocol getApiResponse {
    func getFailure()
    func serviceData(arrayData:[Photo], maxPages: Int)
}

//MARK: Business Logic Here from sending request to handling api response

class ImageViewModal {
    let apiMngr: ApiRequest = ApiRequest()
    var photoData: [Photo] = []
    private var maxPageNo = Int()
    var serviceDelegate:getApiResponse?
    
    //MARK: Send Request To Server

    func sendRequestToServer(_ searchKeyword: SearchRequest)
    {
        apiMngr.fetchImages(request: searchKeyword, completionHandler: { [weak self] (_imgResponse)  in
            
                    if(_imgResponse?.photos != nil)
                    {
                        guard let images = _imgResponse?.getImages() else {
                            return
                        }
                        
                        //MARK: Handle Success and append image data in array
                        self?.photoData.append(contentsOf: images)
                        self?.maxPageNo = _imgResponse?.photos.pages ?? 1
                        DispatchQueue.main.async {
                            self?.serviceDelegate?.serviceData(arrayData: self?.photoData ?? [], maxPages: self?.maxPageNo ?? 1)
                        }
                    }
            else
                    {
                        DispatchQueue.main.async {
                            self?.serviceDelegate?.getFailure()
                        }
            }
                })

    }

}
