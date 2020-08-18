//
//  PictureCollectionCell.swift
//  Kids-LearnWithFun
//
//  Created by sheetal shinde on 15/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import UIKit

protocol PictureCollectionCellProtocol : class {
    func playSoundOnImageClick(getSound : Int )
}

class PictureCollectionCell: UICollectionViewCell {    
    @IBOutlet weak var imgViewCard: UIImageView!
    weak var delegatePictureCollection : PictureCollectionCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgViewCard.contentMode = .scaleAspectFill
        let tapGestureImgViewCard = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgViewCard.addGestureRecognizer(tapGestureImgViewCard)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        delegatePictureCollection?.playSoundOnImageClick(getSound: tag)
    }
}
