//
//  HomeViewController.swift
//  Kids-LearnWithFun
//
//  Created by sheetal shinde on 14/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    @IBOutlet weak var bgScreen: UIImageView!
    @IBOutlet weak var imgVwWildAnimal: UIImageView!
    @IBOutlet weak var imgVwPetAnimal: UIImageView!
    @IBOutlet weak var imgVwBird: UIImageView!
    @IBOutlet weak var imgVwFlower: UIImageView!
    @IBOutlet weak var imgVwTest: UIImageView!
    @IBOutlet weak var imgViewBg: UIImageView!


    
    @IBOutlet weak var heightBottomImg: NSLayoutConstraint!
    @IBOutlet weak var widthIconBgImg: NSLayoutConstraint!
    @IBOutlet weak var widthtIconImg: NSLayoutConstraint!
    @IBOutlet weak var widthBtnHome: NSLayoutConstraint!
    @IBOutlet weak var bottomBgScreen: NSLayoutConstraint!
    @IBOutlet weak var topFloaty: NSLayoutConstraint!


    @IBOutlet weak var btnSound: UIButton!
    @IBOutlet weak var btnNoAds: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var btnCancelSubscription: UIButton!
    let rateUsImg = UIImage(named: "RateUs.png")
    let shareAppImg = UIImage(named: "ShareApp.png")
    @IBOutlet weak var floaty : Floaty!
    @IBOutlet weak var viewParentSetting: UIView!
    @IBOutlet weak var viewtransperent: UIView!
    let defaults = UserDefaults.standard
    var paymentDetailVC : PaymentDetailViewController?
    
    var fromShareApp = false

    var player = AVAudioPlayer()
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    //------------------------------------------------------------------------

    override func viewWillAppear(_ animated: Bool) {
        playBackgroundMusic()
        self.viewtransperent.isHidden = true
        self.viewParentSetting.isHidden = true
        showHideAdsButton()
    }
    override func viewWillDisappear(_ animated: Bool) {
        player.stop()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIScene.willDeactivateNotification, object: nil)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        }
        makeRound(getImgView : imgVwWildAnimal)
        makeRound(getImgView: imgVwPetAnimal)
        makeRound(getImgView: imgVwBird)
        makeRound(getImgView: imgVwFlower)
        
        let tapGestureRecognWildAnimal = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgVwWildAnimal.addGestureRecognizer(tapGestureRecognWildAnimal)
        imgVwWildAnimal.tag = 1

        let tapGestureRecognPetAnimal = UITapGestureRecognizer(
            target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgVwPetAnimal.addGestureRecognizer(tapGestureRecognPetAnimal)
        imgVwPetAnimal.tag = 2

        let tapGestureRecognBird = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgVwBird.addGestureRecognizer(tapGestureRecognBird)
        imgVwBird.tag = 3


        let tapGestureRecognFlower = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgVwFlower.addGestureRecognizer(tapGestureRecognFlower)
        imgVwFlower.tag = 4
        
        
        let tapGestureRecognTest = UITapGestureRecognizer(target: self, action: #selector(testImageTapped(tapGestureRecognizer:)))
        imgVwTest.addGestureRecognizer(tapGestureRecognTest)

        
        
        if defaults.bool(forKey:"PauseHomeSound") {
            btnSound.setBackgroundImage(CommanArray.homeImgSoundOff, for: .normal)
        } else {
            btnSound.setBackgroundImage(CommanArray.homeImgSoundOn, for: .normal)
        }

        //        Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.alarmAlertActivate), userInfo: nil, repeats: true)        viewParentSetting.backgroundColor = UIColor.black
        viewParentSetting.alpha = 0.4

        self.viewtransperent.isHidden = true
        self.viewParentSetting.isHidden = true

        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.clickTransperentView (_:)))
        self.viewParentSetting.addGestureRecognizer(gesture)
        self.floaty.floatingActionButtonDelegate = self
        self.floaty.addItem(icon: rateUsImg, handler: { [self]_ in
            self.floaty.close()
            self.paymentDetailVC = PaymentDetailViewController(nibName: "PaymentDetailViewController", bundle: nil)
            self.paymentDetailVC?.showHomeScreenRateReview = true
            self.showPaymentScreen()
        })
        self.floaty.addItem(icon: shareAppImg, handler: {_ in
            self.paymentDetailVC = PaymentDetailViewController(nibName: "PaymentDetailViewController", bundle: nil)
            self.paymentDetailVC?.showHomeScreenShareApp = true
            self.showPaymentScreen()
            self.floaty.close()
        })
        floaty.items[0].title = "Rate & Review"
        floaty.items[1].title = "Share App"
        
        addWaveBackground(to :viewtransperent)
        //-----------------------------------
        
        if UIScreen.main.bounds.height < 820 {
//            heightBottomImg.constant = 380
            widthIconBgImg.constant = 150
            widthtIconImg.constant = 79.16
            widthBtnHome.constant = 40
            bottomBgScreen.constant = -50
        }
        
        if UIScreen.main.bounds.height < 700 {
            bgScreen.isHidden = true
        }
        
        if UIScreen.main.bounds.height == 844 {
            bottomBgScreen.constant = -20
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIScreen.main.bounds.height < 1030 {
                self.bgScreen.isHidden = true
                
            }
        }

        print("######Ipad size:",UIScreen.main.bounds.height)
    }
    
    func makeRound(getImgView : UIImageView) {
        getImgView.clipsToBounds = true
      //  self.layer.cornerRadius = (self.frame.width + self.frame.height) / 4
        getImgView.layer.masksToBounds = true
       // print("Inside Learn wth fun:",self.frame.width, self.frame.height )
        getImgView.layer.cornerRadius = getImgView.frame.width  / 2
    }

    @objc func willResignActive(_ notification: Notification) {
        // code to execute
        floaty.close()
    }
    func playBackgroundMusic() {
        let path = Bundle.main.path(forResource: "ClockBgMusic", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self
            if defaults.bool(forKey:"PauseHomeSound") {
                btnSound.setBackgroundImage(CommanArray.homeImgSoundOff, for: .normal)
                player.stop()
            } else {
                btnSound.setBackgroundImage(CommanArray.homeImgSoundOn, for: .normal)
                player.play()
            }

        } catch {
            print ("There is an issue with this code!")
        }
    }
    func showHideAdsButton() {
        if defaults.bool(forKey:"IsPrimeUser") {
            if let _ = btnCancelSubscription, let _ = btnCancelSubscription {
                self.btnCancelSubscription.isHidden = false
                self.btnNoAds.isHidden = true
            }
        } else {
            if let _ = btnCancelSubscription, let _ = btnCancelSubscription {
//                self.btnCancelSubscription.isHidden = true
//                self.btnNoAds.isHidden = false
                self.btnCancelSubscription.isHidden = false
                self.btnNoAds.isHidden = true

            }
        }
    }

    @IBAction func funcNoAds(_ sender: Any) {
        paymentDetailVC = PaymentDetailViewController(nibName: "PaymentDetailViewController", bundle: nil)
        paymentDetailVC?.showSubscriptionScreen = false
        showPaymentScreen()
    }
    @IBAction func funcCancelSubscription(_ sender: Any) {
       if btnCancelSubscription.currentImage!.pngData() == (CommanArray.imgCancelSubscription).pngData() {
            btnCancelSubscription.setImage(CommanArray.imgCancelSubscription1, for: .normal)
        } else {
            btnCancelSubscription.setImage(CommanArray.imgCancelSubscription, for: .normal)
        }

        if fromShareApp {
            fromShareApp = false
        } else {
            paymentDetailVC = PaymentDetailViewController(nibName: "PaymentDetailViewController", bundle: nil)
            paymentDetailVC?.showSubscriptionScreen = true
            showPaymentScreen()
        }
    }

    @IBAction func funcSound_ON_OFF(_ sender: Any) {
        if defaults.bool(forKey:"PauseHomeSound") {
            defaults.set(false, forKey: "PauseHomeSound")
            btnSound.setBackgroundImage(CommanArray.homeImgSoundOn, for: .normal)
            player.play()
        } else {
            defaults.set(true, forKey: "PauseHomeSound")
            btnSound.setBackgroundImage(CommanArray.homeImgSoundOff, for: .normal)
            player.stop()
        }
    }
    
    @objc func clickTransperentView(_ sender:UITapGestureRecognizer){
        self.viewtransperent.isHidden = true
        self.viewParentSetting.isHidden = true
    }

    func addWaveBackground(to view: UIView){
          let multipler = CGFloat(0.07)  //0.13
        
          let leftDrop:CGFloat = 0.4 + multipler
          let leftInflexionX: CGFloat = 0.4 + multipler
          let leftInflexionY: CGFloat = 0.47 + multipler

          let rightDrop: CGFloat = 0.3 +  multipler
          let rightInflexionX: CGFloat = 0.6  +  multipler
          let rightInflexionY: CGFloat = 0.22 + multipler

          let backView = UIView(frame: view.frame)
          backView.backgroundColor = .clear
          view.addSubview(backView)
          let backLayer = CAShapeLayer()
          let path = UIBezierPath()
          path.move(to: CGPoint(x: 0, y: 0))
          path.addLine(to: CGPoint(x:0, y: view.frame.height * leftDrop))
          path.addCurve(to: CGPoint(x:225, y: view.frame.height * rightDrop),
                        controlPoint1: CGPoint(x: view.frame.width * leftInflexionX, y: view.frame.height * leftInflexionY),
                        controlPoint2: CGPoint(x: view.frame.width * rightInflexionX, y: view.frame.height * rightInflexionY+30))
          path.addLine(to: CGPoint(x:225, y: 0))
          path.close()
          backLayer.fillColor = CommanArray.settingBgColor.cgColor //UIColor.blue.cgColor
          backLayer.path = path.cgPath
          backView.layer.addSublayer(backLayer)
       }
    @objc func alarmAlertActivate(){
        UIView.animate(withDuration: 0.7) {
            self.imgVwTest.alpha = self.imgVwTest.alpha == 1.0 ? 0.0 : 1.0
        }
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let setPictureVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagesCollectionViewController") as! ImagesCollectionViewController
        if tapGestureRecognizer.view?.tag == 1 {
            setPictureVC.imageArray = CommanArray.fruitsImageArray
            setPictureVC.imageNameArray = CommanArray.fruitsNameArray
            setPictureVC.stringTitle = "Fruits"
            setPictureVC.getTabNumber = 0
        }
        else if tapGestureRecognizer.view?.tag == 2 {
            setPictureVC.imageArray = CommanArray.vegetablesImageArray
            setPictureVC.imageNameArray = CommanArray.vegetablesNameArray
            setPictureVC.stringTitle = "Vegetables"
            setPictureVC.getTabNumber = 1
        }
        else if tapGestureRecognizer.view?.tag == 3 {
            setPictureVC.imageArray = CommanArray.grainsImageArray
            setPictureVC.imageNameArray = CommanArray.grainsNameArray
            setPictureVC.stringTitle = "Grains"
            setPictureVC.getTabNumber = 2
        }
        else if tapGestureRecognizer.view?.tag == 4 {
            setPictureVC.imageArray = CommanArray.spicesImageArray
            setPictureVC.imageNameArray = CommanArray.spicesNameArray
            setPictureVC.stringTitle = "Spices"
            setPictureVC.getTabNumber = 3
        }
        self.navigationController?.pushViewController(setPictureVC, animated: true)
    }
    
    @objc func testImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let setPictureVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
        self.navigationController?.pushViewController(setPictureVC, animated: true)
    }
}

extension HomeViewController : FloatingActionButtonProtocol {
    
    func floatingActionOpen() {
        UIView.animate(withDuration: 0.5, animations: {
            self.btnSetting.transform = CGAffineTransform(rotationAngle: .pi * 0.999)
        })
        viewtransperent.isHidden = false
        viewParentSetting.isHidden = false
    }
    func floatingActionClose() {
        UIView.animate(withDuration: 0.5, animations: {
            self.btnSetting.transform = CGAffineTransform.identity
        })
        viewtransperent.isHidden = true
        viewParentSetting.isHidden = true
    }
}
extension HomeViewController : PayementForParentProtocol {
    //Delegate method implementation
    func showPaymentCostScreen() {
        paymentDetailVC?.view.removeFromSuperview()
        let paymentCostVC = PaymentCostController(nibName: "PaymentCostController", bundle: nil)
        self.navigationController?.pushViewController(paymentCostVC, animated: true)
    }
    
    func showSubscriptionDetailScreen() {
        paymentDetailVC?.view.removeFromSuperview()
        let paymenSubscriptionVC = SubscriptionDetailsController(nibName: "SubscriptionDetailsController", bundle: nil)
        self.navigationController?.pushViewController(paymenSubscriptionVC, animated: true)
    }

    func showPaymentScreen(){
        paymentDetailVC?.view.frame = self.view.bounds
        paymentDetailVC?.delegatePayementForParent = self
        self.view.addSubview(paymentDetailVC?.view ?? UIView())
    }
    
    func appstoreRateAndReview() {
        paymentDetailVC?.view.removeFromSuperview()
        var components = URLComponents(url: CommanArray.app_AppStoreLink!, resolvingAgainstBaseURL: false)
        components?.queryItems = [
          URLQueryItem(name: "action", value: "write-review")
        ]
        guard let writeReviewURL = components?.url else {
          return
        }
        UIApplication.shared.open(writeReviewURL)
    }
    
    func shareApp() {
        paymentDetailVC?.view.removeFromSuperview()
        let activityViewController = UIActivityViewController(
            activityItems: [CommanArray.app_AppStoreLink!],
          applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
             print(success ? "SUCCESS!" : "FAILURE")
            self.fromShareApp = true
            self.btnCancelSubscription.sendActions(for: .touchUpInside)
        }
        self.present(activityViewController, animated: true, completion: nil)
    }

}
extension HomeViewController : AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finished")//It is working now! printed "finished"!
        playBackgroundMusic()
    }
}
