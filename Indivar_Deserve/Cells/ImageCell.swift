//
//  ImageCell.swift
//  Indivar_Deserve
//
//  Created by Indivar on 15/05/21.
//  Copyright © 2021 Indivar. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imgPhoto: CacheImaggeView!
    
    //MARK: Set Image on collectionView Cell
    var photoModal : Photo!{
        didSet
        {
            let imgPath = photoModal.getUrl()
            guard let animalImageUrl = URL(string: imgPath) else { return  }
            imgPhoto.loadImage(fromURL: animalImageUrl, placeHolderImage: "", identifier: photoModal.id ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
