//
//  TestViewController.swift
//  Kids-LearnWithFun3
//
//  Created by sheetal shinde on 24/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import UIKit
import GoogleMobileAds

class TestViewController: UIViewController, PayementForParentProtocol {
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var imgVwTest1: UIImageView!
    @IBOutlet weak var imgVwTest2: UIImageView!
    @IBOutlet weak var imgVwTest3: UIImageView!
    @IBOutlet weak var imgVwTest4: UIImageView!
    @IBOutlet weak var bgAnimateimgeView: UIImageView!
    @IBOutlet weak var imgViewLock2: UIImageView!
    @IBOutlet weak var imgViewLock3: UIImageView!
    @IBOutlet weak var imgViewLock4: UIImageView!
    @IBOutlet weak var widthLockBgImg: NSLayoutConstraint!
    @IBOutlet weak var heightHomeImg: NSLayoutConstraint!
    @IBOutlet weak var btnNoAds: UIButton!

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    let defaults = UserDefaults.standard
    var paymentDetailVC : PaymentDetailViewController?
    var timer: Timer?
    var bannerView: GADBannerView!
    @IBOutlet weak var lblCostTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCostTitle.text = "Test Your Skills"
        //lblCostTitle.textColor = CommanArray.paymentBtnTextColor

        imgViewLock2.layer.borderColor = UIColor.red.cgColor
        imgViewLock2.layer.borderWidth = 2.5
        imgViewLock2.layer.cornerRadius = imgViewLock2.frame.width / 2
        
        imgViewLock3.layer.borderColor = UIColor.red.cgColor
        imgViewLock3.layer.borderWidth = 2.5
        imgViewLock3.layer.cornerRadius = imgViewLock3.frame.width / 2

        imgViewLock4.layer.borderColor = UIColor.red.cgColor
        imgViewLock4.layer.borderWidth = 2.5
        imgViewLock4.layer.cornerRadius = imgViewLock4.frame.width / 2


        let tapGestureRecognImgVwTest1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgVwTest1.addGestureRecognizer(tapGestureRecognImgVwTest1)
        imgVwTest1.tag = 1

        let tapGestureRecognImgVwTest2 = UITapGestureRecognizer(
            target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgVwTest2.addGestureRecognizer(tapGestureRecognImgVwTest2)
        imgVwTest2.tag = 2

        let tapGestureRecognImgVwTest3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgVwTest3.addGestureRecognizer(tapGestureRecognImgVwTest3)
        imgVwTest3.tag = 3


        let tapGestureRecognImgVwTest4 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgVwTest4.addGestureRecognizer(tapGestureRecognImgVwTest4)
        imgVwTest4.tag = 4
        
         let wildGif1 = UIImage.gifImageWithName("QA")
         self.bgAnimateimgeView.image  = wildGif1
        
        if UIScreen.main.bounds.height < 820 {
            widthLockBgImg.constant = 47
            heightHomeImg.constant = 43
            imgViewLock2.layer.cornerRadius = widthLockBgImg.constant/2
            imgViewLock3.layer.cornerRadius = widthLockBgImg.constant/2
            imgViewLock4.layer.cornerRadius = widthLockBgImg.constant/2
        }
        if UIScreen.main.bounds.height < 700 {
            bgAnimateimgeView.isHidden = true
        }
        if !(defaults.bool(forKey:"IsPrimeUser")) {
            bannerView = GADBannerView(adSize: kGADAdSizeBanner)
            addBannerViewToView(bannerView)
            bannerView.adUnitID = CommanArray.Banner_AdUnitId
            bannerView.rootViewController = self
            bannerView.delegate = self
            if Reachability.isConnectedToNetwork() {
                DispatchQueue.main.async {
                    self.bannerView.load(GADRequest())
                }
            } else {
                let alert = UIAlertController(title: "", message: "No Internet Connection.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                    if self.timer == nil {
                        self.timer = Timer.scheduledTimer(timeInterval: CommanArray.timerForAds, target: self, selector: #selector(self.alarmToLoadBannerAds), userInfo: nil, repeats: true)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !defaults.bool(forKey:"IsPrimeUser") {
            if let _ = btnNoAds, let _ = imgViewLock2, let _ = imgViewLock3, let _ = imgViewLock4 {
                self.imgViewLock2.isHidden = false
                self.imgViewLock3.isHidden = false
                self.imgViewLock4.isHidden = false
                if bannerView != nil {
                    if timer == nil {
                        if Reachability.isConnectedToNetwork() {
                            DispatchQueue.main.async {
                                self.bannerView.load(GADRequest())
                            }
                        } else {
                            let alert = UIAlertController(title: "", message: "No Internet Connection.", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                                if self.timer == nil {
                                    self.timer = Timer.scheduledTimer(timeInterval: CommanArray.timerForAds, target: self, selector: #selector(self.alarmToLoadBannerAds), userInfo: nil, repeats: true)
                                }
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if defaults.bool(forKey:"IsPrimeUser") {
            if let _ = btnNoAds, let _ = imgViewLock2, let _ = imgViewLock3, let _ = imgViewLock4 {
                self.btnNoAds.isHidden = true
                self.imgViewLock2.isHidden = true
                self.imgViewLock3.isHidden = true
                self.imgViewLock4.isHidden = true
                if bannerView != nil {
                    bannerView.removeFromSuperview()
                }
            }
        } else {
            if let _ = btnNoAds{
                self.btnNoAds.isHidden = false
            }
        }
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let setTestSolveVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestSolveViewController") as! TestSolveViewController
        if tapGestureRecognizer.view?.tag == 1 {
                    let solveTestArray = [[
                        CommanArray.fruitsNameArray[2]+"-"+"0",
                        CommanArray.fruitsNameArray[10]+"-"+"0",
                        CommanArray.fruitsNameArray[0]+"-"+"1",
                        CommanArray.fruitsNameArray[16]+"-"+"0"
                    ],
                    [
                         CommanArray.fruitsNameArray[3]+"-"+"0",
                         CommanArray.fruitsNameArray[1]+"-"+"1",
                         CommanArray.fruitsNameArray[5]+"-"+"0",
                         CommanArray.fruitsNameArray[11]+"-"+"0"
                    ],
                    [
                         CommanArray.fruitsNameArray[2]+"-"+"1",
                         CommanArray.fruitsNameArray[0]+"-"+"0",
                         CommanArray.fruitsNameArray[7]+"-"+"0",
                         CommanArray.fruitsNameArray[10]+"-"+"0"
                    ],
                    [
                         CommanArray.fruitsNameArray[9]+"-"+"0",
                         CommanArray.fruitsNameArray[16]+"-"+"0",
                         CommanArray.fruitsNameArray[15]+"-"+"0",
                         CommanArray.fruitsNameArray[3]+"-"+"1"
                    ],
                    [
                         CommanArray.fruitsNameArray[8]+"-"+"0",
                         CommanArray.fruitsNameArray[4]+"-"+"1",
                         CommanArray.fruitsNameArray[15]+"-"+"0",
                         CommanArray.fruitsNameArray[14]+"-"+"0"
                    ],
                    [
                         CommanArray.fruitsNameArray[3]+"-"+"0",
                         CommanArray.fruitsNameArray[1]+"-"+"0",
                         CommanArray.fruitsNameArray[5]+"-"+"1",
                         CommanArray.fruitsNameArray[6]+"-"+"0"
                    ],
                    [
                         CommanArray.fruitsNameArray[0]+"-"+"0",
                         CommanArray.fruitsNameArray[6]+"-"+"1",
                         CommanArray.fruitsNameArray[13]+"-"+"0",
                         CommanArray.fruitsNameArray[10]+"-"+"0"
                    ],
                    [
                         CommanArray.fruitsNameArray[11]+"-"+"0",
                         CommanArray.fruitsNameArray[4]+"-"+"0",
                         CommanArray.fruitsNameArray[7]+"-"+"1",
                         CommanArray.fruitsNameArray[16]+"-"+"0"
                     ],
                     [
                         CommanArray.fruitsNameArray[3]+"-"+"0",
                         CommanArray.fruitsNameArray[1]+"-"+"0",
                         CommanArray.fruitsNameArray[5]+"-"+"0",
                         CommanArray.fruitsNameArray[8]+"-"+"1"
                     ],
                     [
                         CommanArray.fruitsNameArray[0]+"-"+"0",
                         CommanArray.fruitsNameArray[9]+"-"+"1",
                         CommanArray.fruitsNameArray[7]+"-"+"0",
                         CommanArray.fruitsNameArray[13]+"-"+"0"
                     ],
                     [
                         CommanArray.fruitsNameArray[3]+"-"+"0",
                         CommanArray.fruitsNameArray[10]+"-"+"1",
                         CommanArray.fruitsNameArray[14]+"-"+"0",
                         CommanArray.fruitsNameArray[6]+"-"+"0"
                     ],
                     [
                         CommanArray.fruitsNameArray[11]+"-"+"1",
                         CommanArray.fruitsNameArray[4]+"-"+"0",
                         CommanArray.fruitsNameArray[0]+"-"+"0",
                         CommanArray.fruitsNameArray[10]+"-"+"0"
                     ],
                     [
                         CommanArray.fruitsNameArray[1]+"-"+"0",
                         CommanArray.fruitsNameArray[8]+"-"+"0",
                         CommanArray.fruitsNameArray[12]+"-"+"1",
                         CommanArray.fruitsNameArray[15]+"-"+"0"
                     ],
                     [
                         CommanArray.fruitsNameArray[2]+"-"+"0",
                         CommanArray.fruitsNameArray[13]+"-"+"1",
                         CommanArray.fruitsNameArray[5]+"-"+"0",
                         CommanArray.fruitsNameArray[4]+"-"+"0"
                     ],
                     [
                         CommanArray.fruitsNameArray[14]+"-"+"1",
                         CommanArray.fruitsNameArray[8]+"-"+"0",
                         CommanArray.fruitsNameArray[3]+"-"+"0",
                         CommanArray.fruitsNameArray[7]+"-"+"0"
                     ],
                     [
                         CommanArray.fruitsNameArray[0]+"-"+"0",
                         CommanArray.fruitsNameArray[2]+"-"+"0",
                         CommanArray.fruitsNameArray[15]+"-"+"1",
                         CommanArray.fruitsNameArray[9]+"-"+"0"
                     ],
                     [
                         CommanArray.fruitsNameArray[6]+"-"+"0",
                         CommanArray.fruitsNameArray[9]+"-"+"0",
                         CommanArray.fruitsNameArray[1]+"-"+"0",
                         CommanArray.fruitsNameArray[16]+"-"+"1"
                     ]]
            setTestSolveVC.showOptionsArray = solveTestArray
            setTestSolveVC.getImageNameArray = CommanArray.fruitsNameArray
            self.navigationController?.pushViewController(setTestSolveVC, animated: true)
        }
        else if tapGestureRecognizer.view?.tag == 2 {
            if defaults.bool(forKey:"IsPrimeUser") {
                let solveTestArray = [[
                          CommanArray.vegetablesNameArray[16]+"-"+"0",
                          CommanArray.vegetablesNameArray[10]+"-"+"0",
                          CommanArray.vegetablesNameArray[0]+"-"+"1",
                          CommanArray.vegetablesNameArray[18]+"-"+"0"
                      ],
                      [
                           CommanArray.vegetablesNameArray[3]+"-"+"0",
                           CommanArray.vegetablesNameArray[1]+"-"+"1",
                           CommanArray.vegetablesNameArray[20]+"-"+"0",
                           CommanArray.vegetablesNameArray[16]+"-"+"0"
                      ],
                      [
                           CommanArray.vegetablesNameArray[2]+"-"+"1",
                           CommanArray.vegetablesNameArray[9]+"-"+"0",
                           CommanArray.vegetablesNameArray[7]+"-"+"0",
                           CommanArray.vegetablesNameArray[10]+"-"+"0"
                      ],
                      [
                           CommanArray.vegetablesNameArray[12]+"-"+"0",
                           CommanArray.vegetablesNameArray[17]+"-"+"0",
                           CommanArray.vegetablesNameArray[15]+"-"+"0",
                           CommanArray.vegetablesNameArray[3]+"-"+"1"
                      ],
                      [
                           CommanArray.vegetablesNameArray[8]+"-"+"0",
                           CommanArray.vegetablesNameArray[4]+"-"+"1",
                           CommanArray.vegetablesNameArray[18]+"-"+"0",
                           CommanArray.vegetablesNameArray[14]+"-"+"0"
                      ],
                      [
                           CommanArray.vegetablesNameArray[16]+"-"+"0",
                           CommanArray.vegetablesNameArray[1]+"-"+"0",
                           CommanArray.vegetablesNameArray[5]+"-"+"1",
                           CommanArray.vegetablesNameArray[19]+"-"+"0"
                      ],
                      [
                           CommanArray.vegetablesNameArray[9]+"-"+"0",
                           CommanArray.vegetablesNameArray[6]+"-"+"1",
                           CommanArray.vegetablesNameArray[13]+"-"+"0",
                           CommanArray.vegetablesNameArray[10]+"-"+"0"
                      ],
                      [
                           CommanArray.vegetablesNameArray[11]+"-"+"0",
                           CommanArray.vegetablesNameArray[4]+"-"+"0",
                           CommanArray.vegetablesNameArray[7]+"-"+"1",
                           CommanArray.vegetablesNameArray[0]+"-"+"0"
                       ],
                       [
                           CommanArray.vegetablesNameArray[3]+"-"+"0",
                           CommanArray.vegetablesNameArray[14]+"-"+"0",
                           CommanArray.vegetablesNameArray[5]+"-"+"0",
                           CommanArray.vegetablesNameArray[8]+"-"+"1"
                       ],
                       [
                           CommanArray.vegetablesNameArray[6]+"-"+"0",
                           CommanArray.vegetablesNameArray[9]+"-"+"1",
                           CommanArray.vegetablesNameArray[1]+"-"+"0",
                           CommanArray.vegetablesNameArray[13]+"-"+"0"
                       ],
                       [
                           CommanArray.vegetablesNameArray[15]+"-"+"0",
                           CommanArray.vegetablesNameArray[10]+"-"+"1",
                           CommanArray.vegetablesNameArray[11]+"-"+"0",
                           CommanArray.vegetablesNameArray[17]+"-"+"0"
                       ],
                       [
                           CommanArray.vegetablesNameArray[11]+"-"+"1",
                           CommanArray.vegetablesNameArray[18]+"-"+"0",
                           CommanArray.vegetablesNameArray[0]+"-"+"0",
                           CommanArray.vegetablesNameArray[6]+"-"+"0"
                       ],
                       [
                           CommanArray.vegetablesNameArray[1]+"-"+"0",
                           CommanArray.vegetablesNameArray[20]+"-"+"0",
                           CommanArray.vegetablesNameArray[12]+"-"+"1",
                           CommanArray.vegetablesNameArray[19]+"-"+"0"
                       ],
                       [
                           CommanArray.vegetablesNameArray[2]+"-"+"0",
                           CommanArray.vegetablesNameArray[13]+"-"+"1",
                           CommanArray.vegetablesNameArray[5]+"-"+"0",
                           CommanArray.vegetablesNameArray[4]+"-"+"0"
                       ],
                       [
                           CommanArray.vegetablesNameArray[14]+"-"+"1",
                           CommanArray.vegetablesNameArray[18]+"-"+"0",
                           CommanArray.vegetablesNameArray[3]+"-"+"0",
                           CommanArray.vegetablesNameArray[7]+"-"+"0"
                       ],
                       [
                           CommanArray.vegetablesNameArray[0]+"-"+"0",
                           CommanArray.vegetablesNameArray[20]+"-"+"0",
                           CommanArray.vegetablesNameArray[15]+"-"+"1",
                           CommanArray.vegetablesNameArray[9]+"-"+"0"
                       ],
                       [
                            CommanArray.vegetablesNameArray[16]+"-"+"1",
                            CommanArray.vegetablesNameArray[1]+"-"+"0",
                            CommanArray.vegetablesNameArray[6]+"-"+"0",
                            CommanArray.vegetablesNameArray[4]+"-"+"0"
                       ],
                       [
                            CommanArray.vegetablesNameArray[12]+"-"+"0",
                            CommanArray.vegetablesNameArray[8]+"-"+"0",
                            CommanArray.vegetablesNameArray[5]+"-"+"0",
                            CommanArray.vegetablesNameArray[17]+"-"+"1"
                        ],
                        [
                            CommanArray.vegetablesNameArray[13]+"-"+"0",
                            CommanArray.vegetablesNameArray[18]+"-"+"1",
                            CommanArray.vegetablesNameArray[2]+"-"+"0",
                            CommanArray.vegetablesNameArray[7]+"-"+"0"
                        ],
                        [
                            CommanArray.vegetablesNameArray[19]+"-"+"1",
                            CommanArray.vegetablesNameArray[1]+"-"+"0",
                            CommanArray.vegetablesNameArray[11]+"-"+"0",
                            CommanArray.vegetablesNameArray[0]+"-"+"0"
                        ],
                        [
                            CommanArray.vegetablesNameArray[3]+"-"+"0",
                            CommanArray.vegetablesNameArray[12]+"-"+"0",
                            CommanArray.vegetablesNameArray[20]+"-"+"1",
                            CommanArray.vegetablesNameArray[9]+"-"+"0"
                        ]
                ]
                setTestSolveVC.showOptionsArray = solveTestArray
                setTestSolveVC.getImageNameArray = CommanArray.vegetablesNameArray
                self.navigationController?.pushViewController(setTestSolveVC, animated: true)
            } else {
                showPaymentScreen()
            }
        }
        else if tapGestureRecognizer.view?.tag == 3 {
            if defaults.bool(forKey:"IsPrimeUser") {
                    let solveTestArray = [[
                        CommanArray.grainsNameArray[2]+"-"+"0",
                        CommanArray.grainsNameArray[10]+"-"+"0",
                        CommanArray.grainsNameArray[0]+"-"+"1",
                        CommanArray.grainsNameArray[16]+"-"+"0"
                    ],
                    [
                         CommanArray.grainsNameArray[3]+"-"+"0",
                         CommanArray.grainsNameArray[1]+"-"+"1",
                         CommanArray.grainsNameArray[5]+"-"+"0",
                         CommanArray.grainsNameArray[11]+"-"+"0"
                    ],
                    [
                         CommanArray.grainsNameArray[2]+"-"+"1",
                         CommanArray.grainsNameArray[0]+"-"+"0",
                         CommanArray.grainsNameArray[7]+"-"+"0",
                         CommanArray.grainsNameArray[10]+"-"+"0"
                    ],
                    [
                         CommanArray.grainsNameArray[9]+"-"+"0",
                         CommanArray.grainsNameArray[16]+"-"+"0",
                         CommanArray.grainsNameArray[15]+"-"+"0",
                         CommanArray.grainsNameArray[3]+"-"+"1"
                    ],
                    [
                         CommanArray.grainsNameArray[8]+"-"+"0",
                         CommanArray.grainsNameArray[4]+"-"+"1",
                         CommanArray.grainsNameArray[15]+"-"+"0",
                         CommanArray.grainsNameArray[14]+"-"+"0"
                    ],
                    [
                         CommanArray.grainsNameArray[3]+"-"+"0",
                         CommanArray.grainsNameArray[1]+"-"+"0",
                         CommanArray.grainsNameArray[5]+"-"+"1",
                         CommanArray.grainsNameArray[6]+"-"+"0"
                    ],
                    [
                         CommanArray.grainsNameArray[0]+"-"+"0",
                         CommanArray.grainsNameArray[6]+"-"+"1",
                         CommanArray.grainsNameArray[13]+"-"+"0",
                         CommanArray.grainsNameArray[10]+"-"+"0"
                    ],
                    [
                         CommanArray.grainsNameArray[11]+"-"+"0",
                         CommanArray.grainsNameArray[4]+"-"+"0",
                         CommanArray.grainsNameArray[7]+"-"+"1",
                         CommanArray.grainsNameArray[16]+"-"+"0"
                     ],
                     [
                         CommanArray.grainsNameArray[3]+"-"+"0",
                         CommanArray.grainsNameArray[1]+"-"+"0",
                         CommanArray.grainsNameArray[5]+"-"+"0",
                         CommanArray.grainsNameArray[8]+"-"+"1"
                     ],
                     [
                         CommanArray.grainsNameArray[0]+"-"+"0",
                         CommanArray.grainsNameArray[9]+"-"+"1",
                         CommanArray.grainsNameArray[7]+"-"+"0",
                         CommanArray.grainsNameArray[13]+"-"+"0"
                     ],
                     [
                         CommanArray.grainsNameArray[3]+"-"+"0",
                         CommanArray.grainsNameArray[10]+"-"+"1",
                         CommanArray.grainsNameArray[14]+"-"+"0",
                         CommanArray.grainsNameArray[6]+"-"+"0"
                     ],
                     [
                         CommanArray.grainsNameArray[11]+"-"+"1",
                         CommanArray.grainsNameArray[4]+"-"+"0",
                         CommanArray.grainsNameArray[0]+"-"+"0",
                         CommanArray.grainsNameArray[10]+"-"+"0"
                     ],
                     [
                         CommanArray.grainsNameArray[1]+"-"+"0",
                         CommanArray.grainsNameArray[8]+"-"+"0",
                         CommanArray.grainsNameArray[12]+"-"+"1",
                         CommanArray.grainsNameArray[15]+"-"+"0"
                     ],
                     [
                         CommanArray.grainsNameArray[2]+"-"+"0",
                         CommanArray.grainsNameArray[13]+"-"+"1",
                         CommanArray.grainsNameArray[5]+"-"+"0",
                         CommanArray.grainsNameArray[4]+"-"+"0"
                     ],
                     [
                         CommanArray.grainsNameArray[14]+"-"+"1",
                         CommanArray.grainsNameArray[8]+"-"+"0",
                         CommanArray.grainsNameArray[3]+"-"+"0",
                         CommanArray.grainsNameArray[7]+"-"+"0"
                     ],
                     [
                         CommanArray.grainsNameArray[0]+"-"+"0",
                         CommanArray.grainsNameArray[2]+"-"+"0",
                         CommanArray.grainsNameArray[15]+"-"+"1",
                         CommanArray.grainsNameArray[9]+"-"+"0"
                     ],
                     [
                         CommanArray.grainsNameArray[6]+"-"+"0",
                         CommanArray.grainsNameArray[9]+"-"+"0",
                         CommanArray.grainsNameArray[1]+"-"+"0",
                         CommanArray.grainsNameArray[16]+"-"+"1"
                     ]]
                setTestSolveVC.showOptionsArray = solveTestArray
                setTestSolveVC.getImageNameArray = CommanArray.grainsNameArray
                self.navigationController?.pushViewController(setTestSolveVC, animated: true)
            } else {
                showPaymentScreen()
            }
        }
        else if tapGestureRecognizer.view?.tag == 4 {
            if defaults.bool(forKey:"IsPrimeUser") {
                    let solveTestArray = [[
                           CommanArray.spicesNameArray[14]+"-"+"0",
                           CommanArray.spicesNameArray[10]+"-"+"0",
                           CommanArray.spicesNameArray[0]+"-"+"1",
                           CommanArray.spicesNameArray[13]+"-"+"0"
                    ],
                    [
                           CommanArray.spicesNameArray[11]+"-"+"0",
                           CommanArray.spicesNameArray[1]+"-"+"1",
                           CommanArray.spicesNameArray[12]+"-"+"0",
                           CommanArray.spicesNameArray[9]+"-"+"0"
                    ],
                    [
                           CommanArray.spicesNameArray[2]+"-"+"1",
                           CommanArray.spicesNameArray[0]+"-"+"0",
                           CommanArray.spicesNameArray[7]+"-"+"0",
                           CommanArray.spicesNameArray[10]+"-"+"0"
                     ],
                     [
                           CommanArray.spicesNameArray[13]+"-"+"0",
                           CommanArray.spicesNameArray[6]+"-"+"0",
                           CommanArray.spicesNameArray[5]+"-"+"0",
                           CommanArray.spicesNameArray[3]+"-"+"1"
                     ],
                     [
                           CommanArray.spicesNameArray[8]+"-"+"0",
                           CommanArray.spicesNameArray[4]+"-"+"1",
                           CommanArray.spicesNameArray[7]+"-"+"0",
                           CommanArray.spicesNameArray[2]+"-"+"0"
                     ],
                     [
                           CommanArray.spicesNameArray[3]+"-"+"0",
                           CommanArray.spicesNameArray[1]+"-"+"0",
                           CommanArray.spicesNameArray[5]+"-"+"1",
                           CommanArray.spicesNameArray[11]+"-"+"0"
                     ],
                     [
                           CommanArray.spicesNameArray[0]+"-"+"0",
                           CommanArray.spicesNameArray[6]+"-"+"1",
                           CommanArray.spicesNameArray[12]+"-"+"0",
                           CommanArray.spicesNameArray[10]+"-"+"0"
                     ],
                     [
                           CommanArray.spicesNameArray[14]+"-"+"0",
                           CommanArray.spicesNameArray[4]+"-"+"0",
                           CommanArray.spicesNameArray[7]+"-"+"1",
                           CommanArray.spicesNameArray[9]+"-"+"0"
                     ],
                     [
                           CommanArray.spicesNameArray[3]+"-"+"0",
                           CommanArray.spicesNameArray[6]+"-"+"0",
                           CommanArray.spicesNameArray[5]+"-"+"0",
                           CommanArray.spicesNameArray[8]+"-"+"1"
                      ],
                      [
                           CommanArray.spicesNameArray[12]+"-"+"0",
                           CommanArray.spicesNameArray[9]+"-"+"1",
                           CommanArray.spicesNameArray[13]+"-"+"0",
                           CommanArray.spicesNameArray[2]+"-"+"0"
                     ],
                     [
                           CommanArray.spicesNameArray[6]+"-"+"0",
                           CommanArray.spicesNameArray[10]+"-"+"1",
                           CommanArray.spicesNameArray[4]+"-"+"0",
                           CommanArray.spicesNameArray[1]+"-"+"0"
                      ],
                      [
                           CommanArray.spicesNameArray[11]+"-"+"1",
                           CommanArray.spicesNameArray[5]+"-"+"0",
                           CommanArray.spicesNameArray[0]+"-"+"0",
                           CommanArray.spicesNameArray[8]+"-"+"0"
                      ],
                      [
                           CommanArray.spicesNameArray[1]+"-"+"0",
                           CommanArray.spicesNameArray[8]+"-"+"0",
                           CommanArray.spicesNameArray[12]+"-"+"1",
                           CommanArray.spicesNameArray[7]+"-"+"0"
                       ],
                       [
                           CommanArray.spicesNameArray[3]+"-"+"0",
                           CommanArray.spicesNameArray[13]+"-"+"1",
                           CommanArray.spicesNameArray[4]+"-"+"0",
                           CommanArray.spicesNameArray[9]+"-"+"0"
                       ],
                       [
                           CommanArray.spicesNameArray[14]+"-"+"1",
                           CommanArray.spicesNameArray[6]+"-"+"0",
                           CommanArray.spicesNameArray[2]+"-"+"0",
                           CommanArray.spicesNameArray[10]+"-"+"0"
                      ]]
                setTestSolveVC.showOptionsArray = solveTestArray
                setTestSolveVC.getImageNameArray = CommanArray.spicesNameArray
                self.navigationController?.pushViewController(setTestSolveVC, animated: true)
            } else {
                showPaymentScreen()
            }
        }
    }
    // MARK: - User defined Functions
     
     @objc func alarmToLoadBannerAds(){
         print("Inside alarmToLoadBannerAds")
            if Reachability.isConnectedToNetwork() {
              if bannerView != nil {
                 print("Inside Load bannerView")
                DispatchQueue.main.async {
                    self.bannerView.load(GADRequest())
                }
             }
         }
     }

     //Start Payment flow
     @IBAction func funcNoAds(_ sender: Any) {
         showPaymentScreen()
     }
     func stopTimer() {
         print("Inside stopTimer")
         if timer != nil {
             timer?.invalidate()
             timer = nil
         }
     }

     //Delegate method implementation
     func showPaymentCostScreen() {
         paymentDetailVC?.view.removeFromSuperview()
         let PaymentCostVC = PaymentCostController(nibName: "PaymentCostController", bundle: nil)
         self.navigationController?.pushViewController(PaymentCostVC, animated: true)
     }
     func showSubscriptionDetailScreen() {
     }

     func showPaymentScreen(){
         paymentDetailVC = PaymentDetailViewController(nibName: "PaymentDetailViewController", bundle: nil)
         paymentDetailVC?.view.frame = self.view.bounds
         paymentDetailVC?.delegatePayementForParent = self
         self.view.addSubview(paymentDetailVC?.view ?? UIView())
     }
     
     func appstoreRateAndReview() {
     }
     
     func shareApp() {
         
     }

     @IBAction func funcGoToTestHome(_ sender: Any) {
         stopTimer()
         navigationController?.popViewController(animated: true)
     }
}
extension TestViewController: GADBannerViewDelegate {
    func addBannerViewToView(_ bannerView: GADBannerView) {
      bannerView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(bannerView)
        if #available(iOS 11.0, *) {
          // In iOS 11, we need to constrain the view to the safe area.
          positionBannerViewFullWidthAtBottomOfSafeArea(bannerView)
        }
        else {
          // In lower iOS versions, safe area is not available so we use
          // bottom layout guide and view edges.
          positionBannerViewFullWidthAtBottomOfView(bannerView)
        }
     }

    func positionBannerViewFullWidthAtBottomOfSafeArea(_ bannerView: UIView) {
      // Position the banner. Stick it to the bottom of the Safe Area.
      // Make it constrained to the edges of the safe area.
      let guide = view.safeAreaLayoutGuide
      NSLayoutConstraint.activate([
        guide.leftAnchor.constraint(equalTo: bannerView.leftAnchor),
        guide.rightAnchor.constraint(equalTo: bannerView.rightAnchor),
        guide.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)
      ])
    }

    func positionBannerViewFullWidthAtBottomOfView(_ bannerView: UIView) {
      view.addConstraint(NSLayoutConstraint(item: bannerView,
                                            attribute: .leading,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .leading,
                                            multiplier: 1,
                                            constant: 0))
      view.addConstraint(NSLayoutConstraint(item: bannerView,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .trailing,
                                            multiplier: 1,
                                            constant: 0))
      view.addConstraint(NSLayoutConstraint(item: bannerView,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: bottomLayoutGuide,
                                            attribute: .top,
                                            multiplier: 1,
                                            constant: 0))
    }

    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("adViewDidReceiveAd")
        if let visibleViewCtrl = UIApplication.shared.keyWindow?.visibleViewController {
            if(visibleViewCtrl.isKind(of: TestViewController.self)){
                print("adViewDidReceiveAd Success")
                if timer == nil {
                    timer = Timer.scheduledTimer(timeInterval: CommanArray.timerForAds, target: self, selector: #selector(self.alarmToLoadBannerAds), userInfo: nil, repeats: true)
                }
            }
        }
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }
}
