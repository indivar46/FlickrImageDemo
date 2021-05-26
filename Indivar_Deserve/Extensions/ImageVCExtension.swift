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
        return imgVwModal.photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath) as? ImageCell
        let modal = self.imgVwModal.photoData[indexPath.row]
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
            calllApiRequest(searchText: searchBar.text!, pageNo: pageNo)
            imgVwModal.photoData.removeAll()
            searchBar.resignFirstResponder()

        }
        else
        {
          
            self.alert(message: result.message ?? "", title: "Sorry")

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
    
    func alert(message: String, title: String = "") {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
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


