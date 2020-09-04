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
        }
        else if tapGestureRecognizer.view?.tag == 2 {
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
        }
        else if tapGestureRecognizer.view?.tag == 3 {
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
        }
        else if tapGestureRecognizer.view?.tag == 4 {
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
        }
        self.navigationController?.pushViewController(setTestSolveVC, animated: true)
    }
    // MARK: - User defined Functions
        @IBAction func funcGoToTestHome(_ sender: Any) {
            interstitial = createAndLoadInterstitial()
            //navigationController?.popViewController(animated: true)
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
