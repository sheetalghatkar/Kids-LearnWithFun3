//
//  TestViewController.swift
//  Kids-LearnWithFun3
//
//  Created by sheetal shinde on 24/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import UIKit

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

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    let defaults = UserDefaults.standard
    var paymentDetailVC : PaymentDetailViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    override func viewWillAppear(_ animated: Bool) {
        if defaults.bool(forKey:"IsPrimeUser") {
            if let _ = imgViewLock2, let _ = imgViewLock3, let _ = imgViewLock4 {
                self.imgViewLock2.isHidden = true
                self.imgViewLock3.isHidden = true
                self.imgViewLock4.isHidden = true
            }
        } else {
            if let _ = imgViewLock2, let _ = imgViewLock3, let _ = imgViewLock4 {
                self.imgViewLock2.isHidden = false
                self.imgViewLock3.isHidden = false
                self.imgViewLock4.isHidden = false
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
        @IBAction func funcGoToTestHome(_ sender: Any) {
            navigationController?.popViewController(animated: true)
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
}
