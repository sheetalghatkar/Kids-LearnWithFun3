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

    
    var player = AVAudioPlayer()
    var bannerView: GADBannerView!
    var getTabNumber = 0
    var imageArray : [UIImage] = []
    var imageNameArray : [String] = []
    var interstitial: GADInterstitial?
    //var soundStatus:Bool = false
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var stringTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnForward.layer.cornerRadius = 25.0
        btnBackward.layer.cornerRadius = 25.0
        btnBackward.isHidden = true
        
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
      //  playSound(getSound : self.imageNameArray[0])
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
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

       // bannerView.load(GADRequest())
    }
    func addBannerViewToView(_ bannerView: GADBannerView) {
      bannerView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(bannerView)
      view.addConstraints(
        [NSLayoutConstraint(item: bannerView,
                            attribute: .bottom,
                            relatedBy: .equal,
                            toItem: bottomLayoutGuide,
                            attribute: .top,
                            multiplier: 1,
                            constant: 0),
         NSLayoutConstraint(item: bannerView,
                            attribute: .centerX,
                            relatedBy: .equal,
                            toItem: view,
                            attribute: .centerX,
                            multiplier: 1,
                            constant: 0)
        ])
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
        }
        appDelegate.IS_Sound_ON = !appDelegate.IS_Sound_ON
    }
    
    @IBAction func funcGoToHome(_ sender: Any) {
        interstitial = createAndLoadInterstitial()
     //   navigationController?.popViewController(animated: true)
    }
    
    @IBAction func funcForwardBtnClick(_ sender: Any)
    {
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
        //playSound(getSound : self.imageNameArray[nextItem.row])
    }

    @IBAction func funcBackwardBtnClick(_ sender: Any)
    {
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
       // playSound(getSound : self.imageNameArray[nextItem.row])
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
            }
            else if closestCellIndex == 0 {
                self.btnBackward.isHidden = true
            } else {
                self.btnForward.isHidden = false
                self.btnBackward.isHidden = false
            }
        }
        //playSound(getSound : imageNameArray[closestCellIndex])
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
extension ImagesCollectionViewController: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("adViewDidReceiveAd")
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
