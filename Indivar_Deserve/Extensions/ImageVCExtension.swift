//
//  ImageVCExtension.swift
//  Indivar_Deserve
//
//  Created by Indivar on 15/05/21.
//  Copyright © 2021 Indivar. All rights reserved.
//

import Foundation
import UIKit

//MARK: Extension for CollectionView DataSource Methods

extension ImageVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath) as? ImageCell
        let modal = self.photoData[indexPath.row]
        cell?.photoModal = modal
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/3.0, height: collectionView.bounds.width/3.0)
    }
}

//MARK: Extension for SearchBar Delegate Methods

extension ImageVC: UISearchBarDelegate
{

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        
//        guard searchBar.text != nil else {
//
//            searchBar.resignFirstResponder()
//            return
//        }
        
        //MARK: Check Search Validation here, however the same can be done using guard but to use common functions for both testcases and controller request , have added this code.

        let request = SearchRequest(searchText: searchBar.text!, pageNo: pageNo)
               let validation = SearchValidations()
               let result = validation.validate(request: request)
        if result.isValid == true {
            sendRequestToServer(request)
            photoData.removeAll()
            searchBar.resignFirstResponder()

        }
        else
        {
            let alert = UIAlertController(title: "Sorry", message: result.message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()

            }


        }
    }
}

//MARK: Extension to show spinner during api cal
var vSpinner : UIView?
extension UIViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView()
        ai.style = .large
        ai.color = .black
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}


