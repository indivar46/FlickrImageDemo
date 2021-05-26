//
//  ViewController.swift
//  Indivar_Deserve
//  Created by Indivar on 15/05/21.
//  Copyright © 2021 Indivar. All rights reserved.

import UIKit

class ImageVC: UIViewController,getApiResponse {
    private var maxPageNo = Int()
    let cellReuseIdentifier = "ImageCell"
    @IBOutlet weak var collectnVw: UICollectionView!
    var pageNo = Int()
    var imgVwModal = ImageViewModal()
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Register a cell
        let cellnib = UINib(nibName: cellReuseIdentifier, bundle: nil)
        collectnVw.register(cellnib, forCellWithReuseIdentifier:cellReuseIdentifier )
        //MARK: Static Text for Initial Search Result when application loads
        searchBar.text = "Nature"
        pageNo = 1
        imgVwModal.serviceDelegate = self
        calllApiRequest(searchText: searchBar.text!, pageNo: pageNo)
    }
    
    //MARK: Api Request
    func calllApiRequest(searchText: String,pageNo: Int) {
        let request = SearchRequest(searchText: searchText, pageNo: pageNo)
        self.showSpinner(onView: self.view)
        imgVwModal.sendRequestToServer(request)
    }
    
    //MARK: Confirm protocol For Api Response Below :
    
    //MARK: Handle Api Success here
    func serviceData(arrayData: [Photo], maxPages: Int) {
        //MARK: Fetch Image Data to populate on collectionView
        imgVwModal.photoData = arrayData
        maxPageNo = maxPages
        DispatchQueue.main.async {
            self.removeSpinner()
            self.collectnVw.reloadData()
        }
    }
    
    //MARK: Handle Error or Failure in api response
    func getFailure() {
        DispatchQueue.main.async {
            self.alert(message: "No Data!", title: "Message")
            self.removeSpinner()
        }
    }
    
    //MARK:  Receive more data from api when user reaches to the bottom
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)  {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
        {
            if pageNo <= maxPageNo
            {
                //MARK:  Increment currentPageNo by 1 and send request to server
                if let searchTxt = searchBar.text {
                    calllApiRequest(searchText: searchTxt, pageNo: pageNo + 1)
                }
            }
        }
    }
}




