//
//  TestSolveCollectionCell.swift
//  Kids-LearnWithFun3
//
//  Created by sheetal shinde on 30/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import UIKit

protocol TestSolveCollectionCellProtocol : class {
    func playSoundForImageStatus(getSound : String )
    func funcForwardBtnClick(_ sender: Any)
}

class TestSolveCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgViewCard1: UIImageView!
    @IBOutlet weak var imgViewCard2: UIImageView!
    @IBOutlet weak var imgViewCard3: UIImageView!
    @IBOutlet weak var imgViewCard4: UIImageView!
    var imageSquareArray : [String] = []
    @IBOutlet weak var statusSignImgView1: UIImageView!
    @IBOutlet weak var statusSignImgView2: UIImageView!
    @IBOutlet weak var statusSignImgView3: UIImageView!
    @IBOutlet weak var statusSignImgView4: UIImageView!
    weak var testSolveDelegate : TestSolveCollectionCellProtocol?
    
    var image1Sound : String = ""
    var image2Sound : String = ""
    var image3Sound : String = ""
    var image4Sound : String = ""


    var isImage1Correct = false
    var isImage2Correct = false
    var isImage3Correct = false
    var isImage4Correct = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hideSignOnImageView()
        let tapGestureImgViewCard1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgViewCard1.addGestureRecognizer(tapGestureImgViewCard1)
        imgViewCard1.tag = 1

        let tapGestureImgViewCard2 = UITapGestureRecognizer(
            target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgViewCard2.addGestureRecognizer(tapGestureImgViewCard2)
        imgViewCard2.tag = 2

        let tapGestureImgViewCard3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgViewCard3.addGestureRecognizer(tapGestureImgViewCard3)
        imgViewCard3.tag = 3

        let tapGestureImgViewCard4 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgViewCard4.addGestureRecognizer(tapGestureImgViewCard4)
        imgViewCard4.tag = 4
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if tapGestureRecognizer.view?.tag == 1 {
            statusSignImgView1.isHidden = false
            self.imgViewCard1.alpha = 0.4
            testSolveDelegate?.playSoundForImageStatus(getSound: image1Sound)
            if isImage1Correct {
                self.imgViewCard1.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                    self.testSolveDelegate?.funcForwardBtnClick(self)
                    self.imgViewCard1.isUserInteractionEnabled = true
                }
            }
        }
        else if tapGestureRecognizer.view?.tag == 2 {
            statusSignImgView2.isHidden = false
            self.imgViewCard2.alpha = 0.4
            testSolveDelegate?.playSoundForImageStatus(getSound: image2Sound)
            if isImage2Correct {
                self.imgViewCard2.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                    self.testSolveDelegate?.funcForwardBtnClick(self)
                    self.imgViewCard2.isUserInteractionEnabled = true
                }
            }
        }
        else if tapGestureRecognizer.view?.tag == 3 {
            statusSignImgView3.isHidden = false
            self.imgViewCard3.alpha = 0.4
            testSolveDelegate?.playSoundForImageStatus(getSound: image3Sound)
            if isImage3Correct {
                self.imgViewCard3.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                    self.testSolveDelegate?.funcForwardBtnClick(self)
                    self.imgViewCard3.isUserInteractionEnabled = true
                }
            }
        }
        else if tapGestureRecognizer.view?.tag == 4 {
            statusSignImgView4.isHidden = false
            self.imgViewCard4.alpha = 0.4
            testSolveDelegate?.playSoundForImageStatus(getSound: image4Sound)
            if isImage4Correct {
                self.imgViewCard4.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                    self.testSolveDelegate?.funcForwardBtnClick(self)
                    self.imgViewCard4.isUserInteractionEnabled = true
                }
            }
        }
    }
    func setImageToSquare() {
        hideSignOnImageView()
        let getFirstImageArray = imageSquareArray[0].split(separator: "-")
        let getSecondImageArray = imageSquareArray[1].split(separator: "-")
        let getThirdImageArray = imageSquareArray[2].split(separator: "-")
        let getForthImageArray = imageSquareArray[3].split(separator: "-")

        self.imgViewCard1.image = UIImage(named: getFirstImageArray[0]+".png")!
        self.imgViewCard2.image = UIImage(named: getSecondImageArray[0]+".png")!
        self.imgViewCard3.image = UIImage(named: getThirdImageArray[0]+".png")!
        self.imgViewCard4.image = UIImage(named: getForthImageArray[0]+".png")!
        
        if getFirstImageArray[1] == "0" {
            self.statusSignImgView1.image = CommanArray.status_Sign_Array[0]
            isImage1Correct = false
            image1Sound = "No"
        }  else {
            self.statusSignImgView1.image = CommanArray.status_Sign_Array[1]
            isImage1Correct = true
            image1Sound = "WellDone"
        }
        if getSecondImageArray[1] == "0" {
            self.statusSignImgView2.image = CommanArray.status_Sign_Array[0]
            isImage2Correct = false
            image2Sound = "Wrong"
        } else {
            self.statusSignImgView2.image = CommanArray.status_Sign_Array[1]
            isImage2Correct = true
            image2Sound = "Excellent"
        }
        if getThirdImageArray[1] == "0" {
            self.statusSignImgView3.image = CommanArray.status_Sign_Array[0]
            isImage3Correct = false
            image3Sound = "No"
        } else {
            self.statusSignImgView3.image = CommanArray.status_Sign_Array[1]
            isImage3Correct = true
            image3Sound = "GreatJob"
        }
        if getForthImageArray[1] == "0" {
            self.statusSignImgView4.image = CommanArray.status_Sign_Array[0]
            isImage4Correct = false
            image4Sound = "Wrong"
        } else {
            self.statusSignImgView4.image = CommanArray.status_Sign_Array[1]
            isImage4Correct = true
            image4Sound = "GreatJob"
        }
    }

  /*  func setImageToSquare() {
        var string1 = Array(imageSquareArray)[0].key
//        let year1 = string1.components(separatedBy: "-").first!
//        let year1 = string1.components(separatedBy: "-").first!


        self.imgViewCard1.image = Array(imageSquareArray)[0].key
        self.imgViewCard2.image = Array(imageSquareArray)[1].key
        self.imgViewCard3.image = Array(imageSquareArray)[2].key
        self.imgViewCard4.image = Array(imageSquareArray)[3].key

//        self.statusSignImgView1.image = Array(CommanArray.status_Sign_Array)[1].value
//        self.statusSignImgView2.image = Array(CommanArray.status_Sign_Array)[1].value
//        self.statusSignImgView3.image = Array(CommanArray.status_Sign_Array)[1].value
//        self.statusSignImgView4.image = Array(CommanArray.status_Sign_Array)[1].value

        if Array(imageSquareArray)[0].value == 0 {
            self.statusSignImgView1.image = Array(CommanArray.status_Sign_Array)[0].value
        }
        if Array(imageSquareArray)[1].value == 0 {
            self.statusSignImgView2.image = Array(CommanArray.status_Sign_Array)[0].value
        }
        if Array(imageSquareArray)[2].value == 0 {
            self.statusSignImgView3.image = Array(CommanArray.status_Sign_Array)[0].value
        }
        if Array(imageSquareArray)[3].value == 0 {
            self.statusSignImgView4.image = Array(CommanArray.status_Sign_Array)[0].value
        }
    }*/
    func hideSignOnImageView() {
        statusSignImgView1.isHidden = true
        statusSignImgView2.isHidden = true
        statusSignImgView3.isHidden = true
        statusSignImgView4.isHidden = true
        self.imgViewCard1.alpha = 1.0
        self.imgViewCard2.alpha = 1.0
        self.imgViewCard3.alpha = 1.0
        self.imgViewCard4.alpha = 1.0
    }
}
