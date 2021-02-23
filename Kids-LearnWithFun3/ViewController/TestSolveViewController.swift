//
//  TestSolveViewController.swift
//  Kids-LearnWithFun3
//
//  Created by sheetal shinde on 28/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class TestSolveViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,TestSolveCollectionCellProtocol {
    @IBOutlet weak var btnSound: UIButton!
    @IBOutlet weak var collectionViewCard: UICollectionView!
    @IBOutlet weak var btnForward: UIButton!
    @IBOutlet weak var btnBackward: UIButton!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnPlayAgain: UIButton!
    @IBOutlet weak var heightBottomImg: NSLayoutConstraint!
    @IBOutlet weak var heightBckBtn: NSLayoutConstraint!
    @IBOutlet weak var heightHomeBtn: NSLayoutConstraint!
    @IBOutlet weak var bgScreen: UIImageView!
    @IBOutlet weak var bottomBgScreen: NSLayoutConstraint!
    @IBOutlet weak var imgViewLoader: UIImageView!
    @IBOutlet weak var viewTransperent: UIView!
    @IBOutlet weak var btnNoAds: UIButton!
    @IBOutlet weak var trailingConstraintTitle: NSLayoutConstraint!

    var soundStatus:Bool = false
    var solveTestArray : [String : [UIImage:Int]] = [:]
    var showOptionsArray : [[String]] = [[]]
    var getImageNameArray : [String] = []
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var player = AVAudioPlayer()
    let defaults = UserDefaults.standard
    var paymentDetailVC : PaymentDetailViewController?
    var currentIndex = 0
    var timer: Timer?
    var clickCount = 0
    var checkCurrentindex = 0
    var fromHomeClick = false
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial?

    override func viewDidLoad() {
        super.viewDidLoad()
        let loaderGif = UIImage.gifImageWithName("Loading")
        imgViewLoader.image = loaderGif
        imgViewLoader.backgroundColor = UIColor.white
        imgViewLoader.layer.borderWidth = 1
        imgViewLoader.layer.borderColor = UIColor.red.cgColor

        btnPlayAgain.layer.borderColor = UIColor.red.cgColor
        btnPlayAgain.layer.borderWidth = 3
        btnPlayAgain.layer.cornerRadius = btnPlayAgain.frame.width / 2
        

        btnBackward.isHidden = true
        if appDelegate.IS_Sound_ON {
            btnSound.setBackgroundImage(UIImage(named: "Sound-On.png"), for: .normal)
        } else {
            btnSound.setBackgroundImage(UIImage(named: "Sound-Off.png"), for: .normal)
        }
        collectionViewCard.register(UINib(nibName: "TestSolveCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TestSolveCollectionCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //depending upon direction of collection view
        self.collectionViewCard?.setCollectionViewLayout(layout, animated: true)
        
        let _: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionViewCard!.collectionViewLayout = layout
        self.lblQuestion.text = getImageNameArray[0]
        playSound(getSound : getImageNameArray[0]+"_Question")
        btnPlayAgain.layer.borderWidth = 3
        btnPlayAgain.layer.borderColor = UIColor.red.cgColor
        btnPlayAgain.layer.cornerRadius = btnPlayAgain.frame.width/2
        if UIScreen.main.bounds.height < 820 {
            bottomBgScreen.constant = -50
            heightBckBtn.constant = 47
            heightHomeBtn.constant = 40
            btnPlayAgain.layer.cornerRadius = (heightHomeBtn.constant+6)/2
        }
        if UIScreen.main.bounds.height < 750 {
            bottomBgScreen.constant = -100
        }

        if UIScreen.main.bounds.height < 700 {
            bgScreen.isHidden = true
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
    // MARK: - User defined Functions
    
    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
    }
    override func viewDidAppear(_ animated: Bool) {
        //Start Timer
        if !defaults.bool(forKey:"IsPrimeUser") {
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

    override func viewWillAppear(_ animated: Bool) {
        if defaults.bool(forKey:"IsPrimeUser") {
            if let _ = btnNoAds {
                self.btnNoAds.isHidden = true
                if bannerView != nil {
                    bannerView.removeFromSuperview()
                }
            }
        } else {
            if let _ = btnNoAds {
                self.trailingConstraintTitle.constant = 75
                self.btnNoAds.isHidden = false
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

    func playSound(getSound : String, isShowNextCell : Bool = false) {
        let path = Bundle.main.path(forResource: getSound, ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            if !btnSound.currentBackgroundImage!.isEqual(CommanArray.imgSoundOff) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.player.play()
                }
            }
        } catch {
            print ("There is an issue with this code!")
        }
    }
    
    func playSoundForImageStatus(getSound : String ) {
        let path = Bundle.main.path(forResource: getSound, ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            if !btnSound.currentBackgroundImage!.isEqual(CommanArray.imgSoundOff) {
                self.player.play()
            }
        } catch {
            print ("There is an issue with this code!")
        }
    }
    
    func createAndLoadInterstitial() -> GADInterstitial? {
        interstitial = GADInterstitial(adUnitID: CommanArray.Interstitial_AdUnitId)

        guard let interstitial = interstitial else {
            return nil
        }

        let request = GADRequest()
        // Remove the following line before you upload the app
//        request.testDevices = ["E16216BC-AA11-4924-A93F-5011846DFFA4"]
        interstitial.load(request)
        interstitial.delegate = self

        return interstitial
    }
    @IBAction func funcGoToTestHome(_ sender: Any) {
        player.stop()
        stopTimer()
        fromHomeClick = true
        if defaults.bool(forKey:"IsPrimeUser") {
            navigationController?.popViewController(animated: true)
        } else {
            self.viewTransperent.isHidden = false
            self.imgViewLoader.isHidden = false
            if Reachability.isConnectedToNetwork() {
                DispatchQueue.main.async {
                    self.interstitial = self.createAndLoadInterstitial()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    if !self.viewTransperent.isHidden {
                        self.viewTransperent.isHidden = true
                        self.imgViewLoader.isHidden = true
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                    self.funcHideLoader()
                    let alert = UIAlertController(title: "", message: "No Internet Connection.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                })
            }
        }
    }
    
    @IBAction func funcSound_ON_OFF(_ sender: Any) {
        if appDelegate.IS_Sound_ON {
            btnSound.setBackgroundImage(CommanArray.imgSoundOff, for: .normal)
            player.stop()
        } else {
            btnSound.setBackgroundImage(CommanArray.imgSoundOn, for: .normal)
            playSound(getSound: getImageNameArray[currentIndex]+"_Question")
        }
        appDelegate.IS_Sound_ON = !appDelegate.IS_Sound_ON
    }
    @IBAction func funcPlayAgainClick(_ sender: Any) {
        player.stop()
        playSound(getSound: getImageNameArray[currentIndex]+"_Question")
    }
    
    @IBAction func funcForwardBtnClick(_ sender: Any)
    {
        if !btnForward.isHidden {
            if !(defaults.bool(forKey:"IsPrimeUser")) {
                clickCount = clickCount + 1
                print("!!!!!!!!!!!!clickCount",clickCount)
                if clickCount >= 10 {
                    clickCount = 0
                    callInterstitialOn10Tap()
                }
            }
            let visibleItems: NSArray = self.collectionViewCard.indexPathsForVisibleItems as NSArray
            let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
            let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
            if nextItem.row < showOptionsArray.count {
                self.collectionViewCard.scrollToItem(at: nextItem, at: .left, animated: true)
                self.lblQuestion.text = getImageNameArray[nextItem.row]
                currentIndex = nextItem.row
                playSound(getSound : getImageNameArray[nextItem.row]+"_Question")
            }
            if nextItem.row == self.showOptionsArray.count - 1 {
                self.btnForward.isHidden = true
            } else if nextItem.row == 0 {
                self.btnBackward.isHidden = true
            }else {
                self.btnForward.isHidden = false
                self.btnBackward.isHidden = false
            }
            let indexPath = IndexPath(item: nextItem.row - 1 , section: 0)
            if let cell = collectionViewCard .cellForItem(at: indexPath) as? TestSolveCollectionCell {
                cell.hideSignOnImageView()
            }
            currentIndex = nextItem.row
            checkCurrentindex = currentIndex
        }
    }

    @IBAction func funcBackwardBtnClick(_ sender: Any)
    {
        if !(defaults.bool(forKey:"IsPrimeUser")) {
            clickCount = clickCount + 1
            print("!!!!!!!!!!!!clickCount",clickCount)
            if clickCount >= 10 {
                clickCount = 0
                callInterstitialOn10Tap()
            }
        }
        let visibleItems: NSArray = self.collectionViewCard.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        if nextItem.row < showOptionsArray.count && nextItem.row >= 0{
            self.collectionViewCard.scrollToItem(at: nextItem, at: .right, animated: true)
            self.lblQuestion.text = getImageNameArray[nextItem.row]
            currentIndex = nextItem.row
            playSound(getSound : getImageNameArray[nextItem.row]+"_Question")
        }
        if nextItem.row == 0 {
            self.btnBackward.isHidden = true
        } else if nextItem.row == self.showOptionsArray.count - 1 {
            self.btnForward.isHidden = true
        } else {
            self.btnBackward.isHidden = false
            self.btnForward.isHidden = false
        }
        let indexPath = IndexPath(item: nextItem.row + 1, section: 0);
        if let cell = collectionViewCard .cellForItem(at: indexPath) as? TestSolveCollectionCell {
                cell.hideSignOnImageView()
        }
        currentIndex = nextItem.row
        checkCurrentindex = currentIndex
    }

    func scrollToNearestVisibleCollectionViewCell() {
        self.collectionViewCard.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.collectionViewCard.contentOffset.x + (self.collectionViewCard.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.collectionViewCard.visibleCells.count {
            let cell = self.collectionViewCard.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.collectionViewCard.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.collectionViewCard.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
            self.lblQuestion.text = getImageNameArray[closestCellIndex]
            if closestCellIndex == self.showOptionsArray.count - 1 {
                self.btnForward.isHidden = true
                self.btnBackward.isHidden = false
            }
            else if closestCellIndex == 0 {
                self.btnBackward.isHidden = true
                self.btnForward.isHidden = false
            } else {
                self.btnForward.isHidden = false
                self.btnBackward.isHidden = false
            }
            let indexPath = IndexPath(item: closestCellIndex, section: 0);
            if let cell = self.collectionViewCard .cellForItem(at: indexPath) as? TestSolveCollectionCell {
                    cell.hideSignOnImageView()
            }
            currentIndex = closestCellIndex
            playSound(getSound : getImageNameArray[closestCellIndex]+"_Question")
        }
    }

    // MARK: - CollectionView Functions

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showOptionsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestSolveCollectionCell", for: indexPath) as? TestSolveCollectionCell else {
            // we failed to get a PersonCell – bail out!
            fatalError("Unable to dequeue PersonCell.")
        }
//        for (key, value) in solveTestArray {
//            print("\(key) -> \(value)")
//        }
//        cell.backgroundColor = UIColor.red
       // cell.imgViewCard2.contentMode = .scale
        // if we're still here it means we got a PersonCell, so we can return it
        
        
        
        let arrayTestSolve = Array(showOptionsArray)[indexPath.row]
        cell.tag = indexPath.row
        cell.testSolveDelegate = self
        cell.imageSquareArray  = arrayTestSolve
        cell.setImageToSquare()
//       cell.imgViewCard1.image = Array(dictArrayTestSolve)[0].key
//       cell.imgViewCard2.image = Array(dictArrayTestSolve)[1].key
//       cell.imgViewCard3.image = Array(dictArrayTestSolve)[2].key
//       cell.imgViewCard4.image = Array(dictArrayTestSolve)[3].key
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionViewCard.frame.width, height: self.collectionViewCard.frame.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollToNearestVisibleCollectionViewCell()
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let visibleIndex = Int(targetContentOffset.pointee.x / scrollView.frame.width)

//        print("Inside scrollViewDidEndDragging")
        if !(defaults.bool(forKey:"IsPrimeUser")) {
            if checkCurrentindex != visibleIndex {
                clickCount = clickCount + 1
                print("!!!!!!!!!!!!clickCount",clickCount)
                if clickCount >= 10 {
                    clickCount = 0
                    callInterstitialOn10Tap()
                }
            }
            checkCurrentindex = visibleIndex
        }
    }

    //Start Payment flow
    
    @IBAction func funcNoAds(_ sender: Any) {
        player.stop()
        showPaymentScreen()
    }
    func showPaymentScreen(){
        paymentDetailVC = PaymentDetailViewController(nibName: "PaymentDetailViewController", bundle: nil)
        paymentDetailVC?.view.frame = self.view.bounds
        paymentDetailVC?.delegatePayementForParent = self
        self.view.addSubview(paymentDetailVC?.view ?? UIView())

    }
    func stopTimer() {
        print("Inside stopTimer")
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    func funcHideLoader() {
        self.viewTransperent.isHidden = true
        self.imgViewLoader.isHidden = true
    }
    func callInterstitialOn10Tap(){
        player.stop()
        self.viewTransperent.isHidden = false
        self.imgViewLoader.isHidden = false
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.main.async {
                self.interstitial = self.createAndLoadInterstitial()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                if !self.viewTransperent.isHidden {
                    self.viewTransperent.isHidden = true
                    self.imgViewLoader.isHidden = true
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                self.funcHideLoader()
                let alert = UIAlertController(title: "", message: "No Internet Connection.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                }))
                self.present(alert, animated: true, completion: nil)
            })
        }
    }
}
extension TestSolveViewController: GADBannerViewDelegate {
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
            if(visibleViewCtrl.isKind(of: TestSolveViewController.self)){
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
extension TestSolveViewController: GADInterstitialDelegate {
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("Interstitial loaded successfully")
        player.stop()
        funcHideLoader()
        ad.present(fromRootViewController: self)
        if fromHomeClick {
            navigationController?.popViewController(animated: true)
        }
    }

    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        funcHideLoader()
        print("Fail to receive interstitial")
        if fromHomeClick {
            navigationController?.popViewController(animated: true)
        }
    }
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        funcHideLoader()
        if fromHomeClick {
            navigationController?.popViewController(animated: true)
        }
        print("dismiss interstitial")
    }
}

extension  TestSolveViewController : PayementForParentProtocol {
    //Delegate method implementation
    func showPaymentCostScreen() {
        paymentDetailVC?.view.removeFromSuperview()
        let PaymentCostVC = PaymentCostController(nibName: "PaymentCostController", bundle: nil)
        self.navigationController?.pushViewController(PaymentCostVC, animated: true)
    }
    
    func showSubscriptionDetailScreen() {
    }
    
    func appstoreRateAndReview() {
    }
    
    func shareApp() {
        
    }

}


