//
//  ImagesCollectionViewController.swift
//  Kids-LearnWithFun
//
//  Created by sheetal shinde on 15/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class ImagesCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,PictureCollectionCellProtocol {

    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var collectionViewCard: UICollectionView!
    @IBOutlet weak var btnForward: UIButton!
    @IBOutlet weak var btnBackward: UIButton!
    @IBOutlet weak var lblCard: UILabel!
    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var viewCollectionContainer: UIView!
    @IBOutlet weak var btnSound: UIButton!
    @IBOutlet weak var imgViewBgVegetable1: UIImageView!
    @IBOutlet weak var imgViewBgVegetable2: UIImageView!
    @IBOutlet weak var imgViewBgSpices: UIImageView!
    @IBOutlet weak var heightHome: NSLayoutConstraint!
    @IBOutlet weak var heightStackView: NSLayoutConstraint!
    @IBOutlet weak var trailingTitlelable: NSLayoutConstraint!

    @IBOutlet weak var imgViewLoader: UIImageView!
    @IBOutlet weak var viewTransperent: UIView!
    @IBOutlet weak var btnNoAds: UIButton!
    var interstitial: GADInterstitial?
    var bannerView: GADBannerView!
    var paymentDetailVC : PaymentDetailViewController?

    var timer: Timer?
    var clickCount = 0
    var checkCurrentindex = 0
    var fromHomeClick = false
    var currentindex = 0

    let defaults = UserDefaults.standard

    var player = AVAudioPlayer()
    var getTabNumber = 0
    var imageArray : [UIImage] = []
    var imageNameArray : [String] = []
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var stringTitle = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        let loaderGif = UIImage.gifImageWithName("Loading")
        imgViewLoader.image = loaderGif
        imgViewLoader.backgroundColor = UIColor.white
        imgViewLoader.layer.borderWidth = 1
        imgViewLoader.layer.borderColor = UIColor.red.cgColor
        btnForward.layer.cornerRadius = 25.0
        btnBackward.layer.cornerRadius = 25.0
        btnBackward.isHidden = true
        viewCollectionContainer.layer.borderWidth = 1.5
        viewCollectionContainer.layer.borderColor = UIColor.red.cgColor
        viewCollectionContainer.layer.cornerRadius = 10.0
        

        if appDelegate.IS_Sound_ON {
            btnSound.setBackgroundImage(UIImage(named: "Sound-On.png"), for: .normal)
        } else {
            btnSound.setBackgroundImage(UIImage(named: "Sound-Off.png"), for: .normal)
        }

        viewCollectionContainer.layer.borderWidth = 1.5
        viewCollectionContainer.layer.cornerRadius = 10.0
        viewCollectionContainer.layer.borderColor = UIColor.red.cgColor
        collectionViewCard.register(UINib(nibName: "PictureCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PictureCollectionCell")

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
        self.lblCard.text = imageNameArray[0]
        self.lblPageTitle.text = stringTitle
        playSound(getSound : self.imageNameArray[0])

        if getTabNumber == 0 {
            self.imgViewBgSpices.image  = UIImage.gifImageWithName("Apple")
        } else if getTabNumber == 1 {
            self.imgViewBgVegetable1.image  = UIImage.gifImageWithName("Brinjal")
            self.imgViewBgVegetable2.image  = UIImage.gifImageWithName("Tomato")
        } else if getTabNumber == 2 {
            self.imgViewBgVegetable1.image  = UIImage.gifImageWithName("Grain")
            self.imgViewBgVegetable2.image  = UIImage.gifImageWithName("Corn")
        } else if getTabNumber == 3 {
            self.imgViewBgSpices.image  = UIImage.gifImageWithName("Chilli")
        }
        if UIScreen.main.bounds.height < 820 {
            heightHome.constant = 42
            heightStackView.constant = 110
        }
        if !defaults.bool(forKey:"IsPrimeUser") {
            self.trailingTitlelable.constant = 70
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
                self.btnNoAds.isHidden = false
            }
            if let _ = trailingTitlelable {
                self.trailingTitlelable.constant = 70
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
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
    
    
    // MARK: - CollectionView Functions

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCollectionCell", for: indexPath) as? PictureCollectionCell else {
            // we failed to get a PersonCell – bail out!
            fatalError("Unable to dequeue PersonCell.")
        }
        cell.tag = indexPath.row
        cell.delegatePictureCollection = self
        cell.imgViewCard.image = imageArray[indexPath.row]
        cell.imgViewCard.contentMode = .scaleToFill

        // if we're still here it means we got a PersonCell, so we can return it
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

        print("Inside scrollViewDidEndDragging",checkCurrentindex)
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

////        if !decelerate {
////            self.scrollToNearestVisibleCollectionViewCell()
////        }
//    }

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


    func playSoundOnImageClick(getSound : Int ) {
        let path = Bundle.main.path(forResource: imageNameArray[getSound], ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            if !btnSound.currentBackgroundImage!.isEqual(UIImage(named: "Sound-Off.png")) {
                self.player.play()
            }
        } catch {
            print ("There is an issue with this code!")
        }
    }
    @IBAction func funcSound_ON_OFF(_ sender: Any) {
        if appDelegate.IS_Sound_ON {
            btnSound.setBackgroundImage(UIImage(named: "Sound-Off.png"), for: .normal)
            player.stop()
        } else {
            btnSound.setBackgroundImage(UIImage(named: "Sound-On.png"), for: .normal)
            playSound(getSound : self.imageNameArray[currentindex])
        }
        appDelegate.IS_Sound_ON = !appDelegate.IS_Sound_ON
    }


    
    @IBAction func funcGoToHome(_ sender: Any) {
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
    func funcHideLoader() {
        self.viewTransperent.isHidden = true
        self.imgViewLoader.isHidden = true
    }
    func callInterstitialOn10Tap(){
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
    @IBAction func funcForwardBtnClick(_ sender: Any)
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
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
               if nextItem.row < imageArray.count {
            self.collectionViewCard.scrollToItem(at: nextItem, at: .left, animated: true)
                self.lblCard.text = self.imageNameArray[nextItem.row]
        }
        if nextItem.row == self.imageArray.count - 1 {
            self.btnForward.isHidden = true
        } else if nextItem.row == 0 {
            self.btnBackward.isHidden = true
        }else {
            self.btnForward.isHidden = false
            self.btnBackward.isHidden = false
        }
        currentindex = nextItem.row
        checkCurrentindex = currentindex
        playSound(getSound : self.imageNameArray[nextItem.row])
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
        if nextItem.row < imageArray.count && nextItem.row >= 0{
            self.collectionViewCard.scrollToItem(at: nextItem, at: .right, animated: true)
            self.lblCard.text = self.imageNameArray[nextItem.row]
        }
        if nextItem.row == 0 {
            self.btnBackward.isHidden = true
        } else if nextItem.row == self.imageArray.count - 1 {
            self.btnForward.isHidden = true
        } else {
            self.btnBackward.isHidden = false
            self.btnForward.isHidden = false
        }
        currentindex = nextItem.row
        checkCurrentindex = currentindex
        playSound(getSound : self.imageNameArray[nextItem.row])
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
            self.lblCard.text = self.imageNameArray[closestCellIndex]
            if closestCellIndex == self.imageArray.count - 1 {
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
        }
        currentindex = closestCellIndex
        playSound(getSound : imageNameArray[closestCellIndex])
    }
    

    func playSound(getSound : String) {
        let path = Bundle.main.path(forResource: getSound, ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            if !btnSound.currentBackgroundImage!.isEqual(UIImage(named: "Sound-Off.png")) {
                player.play()
            }
        } catch {
            print ("There is an issue with this code!")
        }
    }
    
    private func createAndLoadInterstitial() -> GADInterstitial? {
        interstitial = GADInterstitial(adUnitID: CommanArray.Interstitial_AdUnitId)

        guard let interstitial = interstitial else {
            return nil
        }

        let request = GADRequest()
        // Remove the following line before you upload the app
        interstitial.load(request)
        interstitial.delegate = self

        return interstitial
    }

    func stopTimer() {
        print("Inside stopTimer")
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
}
extension ImagesCollectionViewController: GADBannerViewDelegate {
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
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: CommanArray.timerForAds, target: self, selector: #selector(self.alarmToLoadBannerAds), userInfo: nil, repeats: true)
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
extension ImagesCollectionViewController: GADInterstitialDelegate {
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("Interstitial loaded successfully")
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
extension ImagesCollectionViewController : PayementForParentProtocol {
    @IBAction func funcNoAds(_ sender: Any) {
        showPaymentScreen()
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
