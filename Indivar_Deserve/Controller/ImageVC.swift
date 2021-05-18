//
//  ViewController.swift
//  Indivar_Deserve
//
//  Created by Indivar on 15/05/21.
//  Copyright © 2021 Indivar. All rights reserved.
//

import UIKit

class ImageVC: UIViewController  {
    
    private var maxPageNo = Int()
    let cellReuseIdentifier = "ImageCell"
    @IBOutlet weak var collectnVw: UICollectionView!
    var pageNo = Int()
    var photoData: [Photo] = []
    let apiMngr: ApiRequest = ApiRequest()
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Register a cell
        let cellnib = UINib(nibName: "ImageCell", bundle: nil)
        collectnVw.register(cellnib, forCellWithReuseIdentifier:cellReuseIdentifier )
        
        //MARK: Static Text for Initial Search Result when application loads
        searchBar.text = "Nature"
        pageNo = 1

        calllApiRequest()
    }
    
    //MARK: Api Request
    func calllApiRequest()
    {
        let request = SearchRequest(searchText: searchBar.text!, pageNo: pageNo)
        sendRequestToServer(request)
    }
    
    //MARK: Fetch Image Data to populate on collectionView
    func sendRequestToServer(_ searchKeyword: SearchRequest)
    {
        self.showSpinner(onView: self.view)
        
        apiMngr.fetchImages(request: searchKeyword, completionHandler: { [weak self] (_imgResponse)  in
            
                    if(_imgResponse?.photos != nil)
                    {
                        self?.removeSpinner()
                        guard let images = _imgResponse?.getImages() else {
                            return
                        }
                        self?.photoData.append(contentsOf: images)
                        self?.maxPageNo = _imgResponse?.photos.pages ?? 1
                        DispatchQueue.main.async {
                            self?.collectnVw.reloadData()
                        }
        
                    }
            
            else
                    {
                        
                        DispatchQueue.main.async {
                            self?.removeSpinner()
                        }
            }
                })

    }
    
//MARK:  Receive more data from api when user reaches to the bottom
func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
               {
                if pageNo <= maxPageNo
                {
                    
                    //MARK:  Increment currentPageNo by 1 and send request to server
                    pageNo = pageNo + 1
                    
                    if let searchTxt = searchBar.text {
                        let request = SearchRequest(searchText: searchTxt, pageNo: pageNo)
                        sendRequestToServer(request)
                    }
                    
                }
        }
    }
    
}
