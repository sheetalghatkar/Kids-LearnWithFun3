//
//  ImagesCollectionViewController.swift
//  Kids-LearnWithFun
//
//  Created by sheetal shinde on 15/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import UIKit
import AVFoundation
//class ImagesCollectionViewController: UIViewController{
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//        }
//
//}

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
    @IBOutlet weak var imgViewLoader: UIImageView!
    @IBOutlet weak var viewTransperent: UIView!
    let defaults = UserDefaults.standard
    var kidozSDK: KidozSDK?
    var timer: Timer?
    var clickCount = 0
    var fromHomeClick = false

    var player = AVAudioPlayer()
    var getTabNumber = 0
    var imageArray : [UIImage] = []
    var imageNameArray : [String] = []
    //var soundStatus:Bool = false
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var stringTitle = ""
    var currentindex = 0
    var checkCurrentindex = 0
    var nowInitializeInterstitial = false


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
        if !(defaults.bool(forKey:"IsPrimeUser")) {
            if Reachability.isConnectedToNetwork() {
                self.kidozAndBannerInit()
            } else {
                let alert = UIAlertController(title: "", message: "No Internet Connection.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                    if self.timer == nil {
                        self.timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.alarmToLoadBannerAds), userInfo: nil, repeats: true)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }

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
    }
    

    func kidozAndBannerInit() {
        if !(defaults.bool(forKey:"IsPrimeUser")) {
            if (((kidozSDK?.isSDKInitialized()) == nil) || !(kidozSDK!.isSDKInitialized())) {
                kidozSDK = KidozSDK.init()
                kidozSDK?.initialize(withPublisherID: CommanArray.Kidoz_Publisher_ID, securityToken: CommanArray.Kidoz_Publisher_token, with: self)
            } else {
                if (((kidozSDK?.isBannerInitialized()) == nil) || !(kidozSDK!.isBannerInitialized())) {
                    kidozSDK?.initializeBanner(with: self, with: self)
                    kidozSDK?.setBannerPosition(BOTTOM_CENTER)
                } else {
                    kidozSDK?.loadBanner()
                }
            }
        }
    }
    func kidozAndInterstitialInit() {
        if !(defaults.bool(forKey:"IsPrimeUser")) {
            self.viewTransperent.isHidden = false
            self.imgViewLoader.isHidden = false
            if Reachability.isConnectedToNetwork() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 7.0, execute: {
                    if !(self.imgViewLoader.isHidden) {
                        self.funcHideLoader()
                    }
                })
                if (((kidozSDK?.isSDKInitialized()) == nil) || !(kidozSDK!.isSDKInitialized())) {
                    kidozSDK = KidozSDK.init()
                    kidozSDK?.initialize(withPublisherID: CommanArray.Kidoz_Publisher_ID, securityToken: CommanArray.Kidoz_Publisher_token, with: self)
                } else {
                    if (((kidozSDK?.isInterstitialInitialized()) == nil) || !(kidozSDK!.isInterstitialInitialized())){
                        kidozSDK?.initializeInterstitial(with: self)
                    } else {
                        kidozSDK?.loadInterstitial()
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

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollToNearestVisibleCollectionViewCell()
        }
    }
    // MARK: - User defined Functions
    @objc func alarmToLoadBannerAds(){
        print("Inside alarmToLoadBannerAds")
        if !fromHomeClick {
            if Reachability.isConnectedToNetwork() {
                kidozAndBannerInit()
            }
        } else {
            stopTimer()
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
        fromHomeClick = true
        stopTimer()
        if defaults.bool(forKey:"IsPrimeUser") {
            navigationController?.popViewController(animated: true)
        } else {
            nowInitializeInterstitial = true
            self.viewTransperent.isHidden = false
            self.imgViewLoader.isHidden = false

            if Reachability.isConnectedToNetwork() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 7.0, execute: {
                    if !(self.imgViewLoader.isHidden) {
                        self.funcHideLoader()
                        self.navigationController?.popViewController(animated: true)
                    }
                })
                if (((kidozSDK?.isSDKInitialized()) == nil) || !(kidozSDK!.isSDKInitialized())) {
                    kidozSDK = KidozSDK.init()
                    kidozSDK?.initialize(withPublisherID: CommanArray.Kidoz_Publisher_ID, securityToken: CommanArray.Kidoz_Publisher_token, with: self)
                } else {
                    if (((kidozSDK?.isInterstitialInitialized()) == nil) || !(kidozSDK!.isInterstitialInitialized())){
                        kidozSDK?.initializeInterstitial(with: self)
                    } else {
                        kidozSDK?.loadInterstitial()
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

    @IBAction func funcForwardBtnClick(_ sender: Any)
    {
        if !(defaults.bool(forKey:"IsPrimeUser")) {
            clickCount = clickCount + 1
//            print("!!!!!!!!!!!!clickCount",clickCount)
            if clickCount >= 10 {
                self.viewTransperent.isHidden = false
                self.imgViewLoader.isHidden = false
                clickCount = 0
                nowInitializeInterstitial = true
                kidozAndInterstitialInit()
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
//            print("!!!!!!!!!!!!clickCount",clickCount)
            if clickCount >= 10 {
                self.viewTransperent.isHidden = false
                self.imgViewLoader.isHidden = false
                clickCount = 0
                nowInitializeInterstitial = true
                kidozAndInterstitialInit()
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
        print("scrollToNearestVisibleCollectionViewCell@@@@")
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
        
        if !(defaults.bool(forKey:"IsPrimeUser")) {
            if checkCurrentindex != currentindex {
                clickCount = clickCount + 1
//                print("!!!!!!!!!!!!clickCount",clickCount)
                if clickCount >= 10 {
                    self.viewTransperent.isHidden = false
                    self.imgViewLoader.isHidden = false
                    clickCount = 0
                    nowInitializeInterstitial = true
                    kidozAndInterstitialInit()
                }
            }
            checkCurrentindex = currentindex
        }
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

    func funcHideLoader() {
        self.viewTransperent.isHidden = true
        self.imgViewLoader.isHidden = true
    }

    func stopTimer() {
        print("Inside stopTimer")
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }


}
extension ImagesCollectionViewController : KDZInitDelegate {
    func onInitSuccess() {
        print("onInitSuccess")
        if(((kidozSDK?.isSDKInitialized()) != nil) && (kidozSDK!.isSDKInitialized()))
        {
            if nowInitializeInterstitial {
                kidozSDK?.initializeInterstitial(with: self)
            } else {
                kidozSDK?.initializeBanner(with: self, with: self)
                kidozSDK?.setBannerPosition(BOTTOM_CENTER)
            }
        }
    }
    func onInitError(error : String) {
        print("onInitError")
    }
}
extension ImagesCollectionViewController: KDZBannerDelegate {
    func bannerDidInitialize() {
        print("bannerDidInitialize")
        kidozSDK?.loadBanner()
    }
    func bannerDidClose() {
        print("bannerDidClose")
    }
    func bannerDidOpen() {
        print("bannerDidOpen")
    }
    func bannerIsReady() {
        print("bannerIsReady")
        kidozSDK?.showBanner()
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.alarmToLoadBannerAds), userInfo: nil, repeats: true)
        }
    }
    func bannerReturnedWithNoOffers() {
        print("bannerReturnedWithNoOffers")
    }
    func bannerLoadFailed() {
        print("bannerLoadFailed")
    }
    func bannerDidReciveError (_ errorMessage : String) {
        print("bannerDidReciveError")
    }
    func bannerLeftApplication() {
        stopTimer()
        print("bannerLeftApplication")
    }
}
extension ImagesCollectionViewController: KDZInterstitialDelegate {
    func interstitialDidInitialize() {
        print("interstitialDidInitialize")
        kidozSDK?.loadInterstitial()
    }
    func interstitialDidClose(){
        print("interstitialDidClose")
        if fromHomeClick {
            navigationController?.popViewController(animated: true)
        }
    }
    func interstitialDidOpen(){
        print("interstitialDidOpen")
    }
    func interstitialIsReady(){
        funcHideLoader()
        print("interstitialIsReady")
        kidozSDK?.showInterstitial()
    }
    func interstitialReturnedWithNoOffers() {
        print("interstitialReturnedWithNoOffers")
    }
    func interstitialDidPause() {
        print("interstitialDidPause")
    }
    func interstitialDidResume() {
        print("interstitialDidResume")
    }
    func interstitialLoadFailed() {
        print("interstitialLoadFailed")
        funcHideLoader()
        if fromHomeClick {
            navigationController?.popViewController(animated: true)
        }
    }

    func interstitialDidReciveError(_ errorMessage : String) {
        print("interstitialDidReciveError", errorMessage)
        funcHideLoader()
        if fromHomeClick {
          navigationController?.popViewController(animated: true)
        }
    }
    
    func interstitialLeftApplication() {
        print("interstitialLeftApplication")
        stopTimer()
        funcHideLoader()
        if fromHomeClick {
            navigationController?.popViewController(animated: true)
        }
    }
}
