//
//  TestViewController.swift
//  Kids-LearnWithFun3
//
//  Created by sheetal shinde on 24/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import UIKit
import GoogleMobileAds

class TestViewController: UIViewController {
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var imgVwTest1: UIImageView!
    @IBOutlet weak var imgVwTest2: UIImageView!
    @IBOutlet weak var imgVwTest3: UIImageView!
    @IBOutlet weak var imgVwTest4: UIImageView!
    var interstitial: GADInterstitial?
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

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

    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let setTestSolveVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestSolveViewController") as! TestSolveViewController
        if tapGestureRecognizer.view?.tag == 1 {
            let solveTestArray = [[
                      CommanArray.houseHoldThingsNameArray[16]+"-"+"0",
                      CommanArray.houseHoldThingsNameArray[10]+"-"+"0",
                      CommanArray.houseHoldThingsNameArray[0]+"-"+"1",
                      CommanArray.houseHoldThingsNameArray[7]+"-"+"0"
                  ],
                  [
                       CommanArray.houseHoldThingsNameArray[3]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[1]+"-"+"1",
                       CommanArray.houseHoldThingsNameArray[18]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[16]+"-"+"0"
                  ],
                  [
                       CommanArray.houseHoldThingsNameArray[2]+"-"+"1",
                       CommanArray.houseHoldThingsNameArray[0]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[7]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[10]+"-"+"0"
                  ],
                  [
                       CommanArray.houseHoldThingsNameArray[12]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[17]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[15]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[3]+"-"+"1"
                  ],
                  [
                       CommanArray.houseHoldThingsNameArray[8]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[4]+"-"+"1",
                       CommanArray.houseHoldThingsNameArray[7]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[14]+"-"+"0"
                  ],
                  [
                       CommanArray.houseHoldThingsNameArray[16]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[1]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[5]+"-"+"1",
                       CommanArray.houseHoldThingsNameArray[19]+"-"+"0"
                  ],
                  [
                       CommanArray.houseHoldThingsNameArray[24]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[6]+"-"+"1",
                       CommanArray.houseHoldThingsNameArray[13]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[10]+"-"+"0"
                  ],
                  [
                       CommanArray.houseHoldThingsNameArray[23]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[4]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[7]+"-"+"1",
                       CommanArray.houseHoldThingsNameArray[21]+"-"+"0"
                   ],
                   [
                       CommanArray.houseHoldThingsNameArray[3]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[14]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[5]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[8]+"-"+"1"
                   ],
                   [
                       CommanArray.houseHoldThingsNameArray[17]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[9]+"-"+"1",
                       CommanArray.houseHoldThingsNameArray[7]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[13]+"-"+"0"
                   ],
                   [
                       CommanArray.houseHoldThingsNameArray[20]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[10]+"-"+"1",
                       CommanArray.houseHoldThingsNameArray[11]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[21]+"-"+"0"
                   ],
                   [
                       CommanArray.houseHoldThingsNameArray[11]+"-"+"1",
                       CommanArray.houseHoldThingsNameArray[18]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[0]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[22]+"-"+"0"
                   ],
                   [
                       CommanArray.houseHoldThingsNameArray[1]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[20]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[12]+"-"+"1",
                       CommanArray.houseHoldThingsNameArray[19]+"-"+"0"
                   ],
                   [
                       CommanArray.houseHoldThingsNameArray[2]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[13]+"-"+"1",
                       CommanArray.houseHoldThingsNameArray[5]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[4]+"-"+"0"
                   ],
                   [
                       CommanArray.houseHoldThingsNameArray[14]+"-"+"1",
                       CommanArray.houseHoldThingsNameArray[23]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[3]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[7]+"-"+"0"
                   ],
                   [
                       CommanArray.houseHoldThingsNameArray[0]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[2]+"-"+"0",
                       CommanArray.houseHoldThingsNameArray[15]+"-"+"1",
                       CommanArray.houseHoldThingsNameArray[9]+"-"+"0"
                   ],
                   [
                        CommanArray.houseHoldThingsNameArray[16]+"-"+"1",
                        CommanArray.houseHoldThingsNameArray[2]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[6]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[21]+"-"+"0"
                   ],
                   [
                        CommanArray.houseHoldThingsNameArray[23]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[8]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[5]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[17]+"-"+"1"
                    ],
                    [
                        CommanArray.houseHoldThingsNameArray[13]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[18]+"-"+"1",
                        CommanArray.houseHoldThingsNameArray[22]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[7]+"-"+"0"
                    ],
                    [
                        CommanArray.houseHoldThingsNameArray[19]+"-"+"1",
                        CommanArray.houseHoldThingsNameArray[1]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[11]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[24]+"-"+"0"
                    ],
                    [
                        CommanArray.houseHoldThingsNameArray[3]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[12]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[20]+"-"+"1",
                        CommanArray.houseHoldThingsNameArray[9]+"-"+"0"
                    ],
                    [
                        CommanArray.houseHoldThingsNameArray[10]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[19]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[0]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[21]+"-"+"1"
                    ],
                    [
                        CommanArray.houseHoldThingsNameArray[3]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[22]+"-"+"1",
                        CommanArray.houseHoldThingsNameArray[8]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[17]+"-"+"0"
                    ],
                    [
                        CommanArray.houseHoldThingsNameArray[20]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[6]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[23]+"-"+"1",
                        CommanArray.houseHoldThingsNameArray[18]+"-"+"0"
                    ],
                    [
                        CommanArray.houseHoldThingsNameArray[24]+"-"+"1",
                        CommanArray.houseHoldThingsNameArray[0]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[4]+"-"+"0",
                        CommanArray.houseHoldThingsNameArray[14]+"-"+"0"
                    ]
            ]
            setTestSolveVC.showOptionsArray = solveTestArray
            setTestSolveVC.getImageNameArray = CommanArray.houseHoldThingsNameArray
        }
        else if tapGestureRecognizer.view?.tag == 2 {
            let solveTestArray = [
                  [
                     CommanArray.kitchenUtensilsNameArray[2]+"-"+"0",
                     CommanArray.kitchenUtensilsNameArray[9]+"-"+"0",
                     CommanArray.kitchenUtensilsNameArray[0]+"-"+"1",
                     CommanArray.kitchenUtensilsNameArray[7]+"-"+"0"
                  ],
                  [
                      CommanArray.kitchenUtensilsNameArray[3]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[1]+"-"+"1",
                      CommanArray.kitchenUtensilsNameArray[5]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[4]+"-"+"0"
                  ],
                  [
                      CommanArray.kitchenUtensilsNameArray[2]+"-"+"1",
                      CommanArray.kitchenUtensilsNameArray[8]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[7]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[10]+"-"+"0"
                  ],
                  [
                      CommanArray.kitchenUtensilsNameArray[9]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[1]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[5]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[3]+"-"+"1"
                  ],
                  [
                      CommanArray.kitchenUtensilsNameArray[8]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[4]+"-"+"1",
                      CommanArray.kitchenUtensilsNameArray[7]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[0]+"-"+"0"
                  ],
                  [
                      CommanArray.kitchenUtensilsNameArray[3]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[1]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[5]+"-"+"1",
                      CommanArray.kitchenUtensilsNameArray[6]+"-"+"0"
                  ],
                  [
                      CommanArray.kitchenUtensilsNameArray[0]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[6]+"-"+"1",
                      CommanArray.kitchenUtensilsNameArray[2]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[10]+"-"+"0"
                  ],
                  [
                      CommanArray.kitchenUtensilsNameArray[1]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[4]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[7]+"-"+"1",
                      CommanArray.kitchenUtensilsNameArray[9]+"-"+"0"
                  ],
                  [
                      CommanArray.kitchenUtensilsNameArray[6]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[10]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[5]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[8]+"-"+"1"
                  ],
                  [
                      CommanArray.kitchenUtensilsNameArray[0]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[9]+"-"+"1",
                      CommanArray.kitchenUtensilsNameArray[2]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[3]+"-"+"0"
                  ],
                  [
                      CommanArray.kitchenUtensilsNameArray[4]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[10]+"-"+"1",
                      CommanArray.kitchenUtensilsNameArray[1]+"-"+"0",
                      CommanArray.kitchenUtensilsNameArray[6]+"-"+"0"
                  ]
            ]
            setTestSolveVC.showOptionsArray = solveTestArray
            setTestSolveVC.getImageNameArray = CommanArray.kitchenUtensilsNameArray
        }
        else if tapGestureRecognizer.view?.tag == 3 {
            let solveTestArray = [
                [
                   CommanArray.gardeningNameArray[2]+"-"+"0",
                   CommanArray.gardeningNameArray[10]+"-"+"0",
                   CommanArray.gardeningNameArray[0]+"-"+"1",
                   CommanArray.gardeningNameArray[11]+"-"+"0"
                ],
                [
                   CommanArray.gardeningNameArray[8]+"-"+"0",
                   CommanArray.gardeningNameArray[1]+"-"+"1",
                   CommanArray.gardeningNameArray[5]+"-"+"0",
                   CommanArray.gardeningNameArray[9]+"-"+"0"
                ],
                [
                   CommanArray.gardeningNameArray[2]+"-"+"1",
                   CommanArray.gardeningNameArray[12]+"-"+"0",
                   CommanArray.gardeningNameArray[7]+"-"+"0",
                   CommanArray.gardeningNameArray[10]+"-"+"0"
                ],
                [
                   CommanArray.gardeningNameArray[9]+"-"+"0",
                   CommanArray.gardeningNameArray[6]+"-"+"0",
                   CommanArray.gardeningNameArray[5]+"-"+"0",
                   CommanArray.gardeningNameArray[3]+"-"+"1"
                ],
                [
                   CommanArray.gardeningNameArray[8]+"-"+"0",
                   CommanArray.gardeningNameArray[4]+"-"+"1",
                   CommanArray.gardeningNameArray[7]+"-"+"0",
                   CommanArray.gardeningNameArray[11]+"-"+"0"
                ],
                [
                   CommanArray.gardeningNameArray[3]+"-"+"0",
                   CommanArray.gardeningNameArray[12]+"-"+"0",
                   CommanArray.gardeningNameArray[5]+"-"+"1",
                   CommanArray.gardeningNameArray[6]+"-"+"0"
                ],
                [
                   CommanArray.gardeningNameArray[0]+"-"+"0",
                   CommanArray.gardeningNameArray[6]+"-"+"1",
                   CommanArray.gardeningNameArray[1]+"-"+"0",
                   CommanArray.gardeningNameArray[2]+"-"+"0"
                ],
                [
                   CommanArray.gardeningNameArray[11]+"-"+"0",
                   CommanArray.gardeningNameArray[4]+"-"+"0",
                   CommanArray.gardeningNameArray[7]+"-"+"1",
                   CommanArray.gardeningNameArray[9]+"-"+"0"
                ],
                [
                   CommanArray.gardeningNameArray[3]+"-"+"0",
                   CommanArray.gardeningNameArray[1]+"-"+"0",
                   CommanArray.gardeningNameArray[5]+"-"+"0",
                   CommanArray.gardeningNameArray[8]+"-"+"1"
                ],
                [
                   CommanArray.gardeningNameArray[0]+"-"+"0",
                   CommanArray.gardeningNameArray[9]+"-"+"1",
                   CommanArray.gardeningNameArray[4]+"-"+"0",
                   CommanArray.gardeningNameArray[12]+"-"+"0"
                ],
                [
                   CommanArray.gardeningNameArray[3]+"-"+"0",
                   CommanArray.gardeningNameArray[10]+"-"+"1",
                   CommanArray.gardeningNameArray[2]+"-"+"0",
                   CommanArray.gardeningNameArray[6]+"-"+"0"
                ],
                [
                   CommanArray.gardeningNameArray[11]+"-"+"1",
                   CommanArray.gardeningNameArray[4]+"-"+"0",
                   CommanArray.gardeningNameArray[0]+"-"+"0",
                   CommanArray.gardeningNameArray[10]+"-"+"0"
                ],
                [
                   CommanArray.gardeningNameArray[1]+"-"+"0",
                   CommanArray.gardeningNameArray[8]+"-"+"0",
                   CommanArray.gardeningNameArray[12]+"-"+"1",
                   CommanArray.gardeningNameArray[7]+"-"+"0"
                ]
            ]
            setTestSolveVC.showOptionsArray = solveTestArray
            setTestSolveVC.getImageNameArray = CommanArray.gardeningNameArray
        }
        else if tapGestureRecognizer.view?.tag == 4 {
            let solveTestArray = [[
                    CommanArray.schoolNameArray[2]+"-"+"0",
                    CommanArray.schoolNameArray[10]+"-"+"0",
                    CommanArray.schoolNameArray[0]+"-"+"1",
                    CommanArray.schoolNameArray[13]+"-"+"0"
                ],
               [
                       CommanArray.schoolNameArray[11]+"-"+"0",
                       CommanArray.schoolNameArray[1]+"-"+"1",
                       CommanArray.schoolNameArray[12]+"-"+"0",
                       CommanArray.schoolNameArray[9]+"-"+"0"
                   ],
                 [
                       CommanArray.schoolNameArray[2]+"-"+"1",
                       CommanArray.schoolNameArray[0]+"-"+"0",
                       CommanArray.schoolNameArray[7]+"-"+"0",
                       CommanArray.schoolNameArray[10]+"-"+"0"
                   ],
                 [
                       CommanArray.schoolNameArray[13]+"-"+"0",
                       CommanArray.schoolNameArray[6]+"-"+"0",
                       CommanArray.schoolNameArray[5]+"-"+"0",
                       CommanArray.schoolNameArray[3]+"-"+"1"
                   ],
                [
                       CommanArray.schoolNameArray[8]+"-"+"0",
                       CommanArray.schoolNameArray[4]+"-"+"1",
                       CommanArray.schoolNameArray[7]+"-"+"0",
                       CommanArray.schoolNameArray[2]+"-"+"0"
                   ],
                [
                       CommanArray.schoolNameArray[3]+"-"+"0",
                       CommanArray.schoolNameArray[1]+"-"+"0",
                       CommanArray.schoolNameArray[5]+"-"+"1",
                       CommanArray.schoolNameArray[11]+"-"+"0"
                   ],
                [
                       CommanArray.schoolNameArray[0]+"-"+"0",
                       CommanArray.schoolNameArray[6]+"-"+"1",
                       CommanArray.schoolNameArray[12]+"-"+"0",
                       CommanArray.schoolNameArray[10]+"-"+"0"
                   ],
                 [
                       CommanArray.schoolNameArray[11]+"-"+"0",
                       CommanArray.schoolNameArray[4]+"-"+"0",
                       CommanArray.schoolNameArray[7]+"-"+"1",
                       CommanArray.schoolNameArray[9]+"-"+"0"
                   ],
                [
                       CommanArray.schoolNameArray[3]+"-"+"0",
                       CommanArray.schoolNameArray[6]+"-"+"0",
                       CommanArray.schoolNameArray[5]+"-"+"0",
                       CommanArray.schoolNameArray[8]+"-"+"1"
                   ],
                 [
                       CommanArray.schoolNameArray[12]+"-"+"0",
                       CommanArray.schoolNameArray[9]+"-"+"1",
                       CommanArray.schoolNameArray[13]+"-"+"0",
                       CommanArray.schoolNameArray[2]+"-"+"0"
                   ],
                 [
                       CommanArray.schoolNameArray[6]+"-"+"0",
                       CommanArray.schoolNameArray[10]+"-"+"1",
                       CommanArray.schoolNameArray[4]+"-"+"0",
                       CommanArray.schoolNameArray[1]+"-"+"0"
                   ],
                 [
                       CommanArray.schoolNameArray[11]+"-"+"1",
                       CommanArray.schoolNameArray[5]+"-"+"0",
                       CommanArray.schoolNameArray[0]+"-"+"0",
                       CommanArray.schoolNameArray[8]+"-"+"0"
                   ],
                [
                       CommanArray.schoolNameArray[1]+"-"+"0",
                       CommanArray.schoolNameArray[8]+"-"+"0",
                       CommanArray.schoolNameArray[12]+"-"+"1",
                       CommanArray.schoolNameArray[7]+"-"+"0"
                   ],
                 [
                       CommanArray.schoolNameArray[3]+"-"+"0",
                       CommanArray.schoolNameArray[13]+"-"+"1",
                       CommanArray.schoolNameArray[4]+"-"+"0",
                       CommanArray.schoolNameArray[9]+"-"+"0"
                   ]]
            
            setTestSolveVC.showOptionsArray = solveTestArray
            setTestSolveVC.getImageNameArray = CommanArray.schoolNameArray
        }
        self.navigationController?.pushViewController(setTestSolveVC, animated: true)
    }
    // MARK: - User defined Functions
        @IBAction func funcGoToTestHome(_ sender: Any) {
          //  interstitial = createAndLoadInterstitial()
        navigationController?.popViewController(animated: true)
        }

    private func createAndLoadInterstitial() -> GADInterstitial? {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-8501671653071605/2568258533")

        guard let interstitial = interstitial else {
            return nil
        }

        let request = GADRequest()
        // Remove the following line before you upload the app
        request.testDevices = ["E16216BC-AA11-4924-A93F-5011846DFFA4"]
        interstitial.load(request)
        interstitial.delegate = self

        return interstitial
    }

}
extension TestViewController: GADInterstitialDelegate {
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("Interstitial loaded successfully")
        ad.present(fromRootViewController: self)
        navigationController?.popViewController(animated: true)
    }

    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        print("Fail to receive interstitial")
        navigationController?.popViewController(animated: true)
    }
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("dismiss interstitial")
    }
    

}
