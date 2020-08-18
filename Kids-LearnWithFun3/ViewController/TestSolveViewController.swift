//
//  TestSolveViewController.swift
//  Kids-LearnWithFun3
//
//  Created by sheetal shinde on 28/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import UIKit
import AVFoundation

class TestSolveViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,TestSolveCollectionCellProtocol {
    @IBOutlet weak var btnSound: UIButton!
    @IBOutlet weak var collectionViewCard: UICollectionView!
    @IBOutlet weak var btnForward: UIButton!
    @IBOutlet weak var btnBackward: UIButton!
    @IBOutlet weak var lblQuestion: UILabel!

    var soundStatus:Bool = false
    var solveTestArray : [String : [UIImage:Int]] = [:]
    var showOptionsArray : [[String]] = [[]]
    var getImageNameArray : [String] = []
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var player = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    // MARK: - User defined Functions
    
    func playSound(getSound : String, isShowNextCell : Bool = false) {
        let path = Bundle.main.path(forResource: getSound, ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            if !btnSound.currentBackgroundImage!.isEqual(UIImage(named: "Sound-Off.png")) {
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
            if !btnSound.currentBackgroundImage!.isEqual(UIImage(named: "Sound-Off.png")) {
                self.player.play()
            }
        } catch {
            print ("There is an issue with this code!")
        }
    }

    @IBAction func funcGoToTestHome(_ sender: Any) {
//        interstitial = createAndLoadInterstitial()
        navigationController?.popViewController(animated: true)
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
    
    @IBAction func funcForwardBtnClick(_ sender: Any)
    {
        if !btnForward.isHidden {
            let visibleItems: NSArray = self.collectionViewCard.indexPathsForVisibleItems as NSArray
            let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
            let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
            if nextItem.row < showOptionsArray.count {
                self.collectionViewCard.scrollToItem(at: nextItem, at: .left, animated: true)
                self.lblQuestion.text = getImageNameArray[nextItem.row]
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
        }
    }

    @IBAction func funcBackwardBtnClick(_ sender: Any)
    {
        let visibleItems: NSArray = self.collectionViewCard.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        if nextItem.row < showOptionsArray.count && nextItem.row >= 0{
            self.collectionViewCard.scrollToItem(at: nextItem, at: .right, animated: true)
            self.lblQuestion.text = getImageNameArray[nextItem.row]
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
            }
            else if closestCellIndex == 0 {
                self.btnBackward.isHidden = true
            } else {
                self.btnForward.isHidden = false
                self.btnBackward.isHidden = false
            }
            let indexPath = IndexPath(item: closestCellIndex, section: 0);
            if let cell = self.collectionViewCard .cellForItem(at: indexPath) as? TestSolveCollectionCell {
                    cell.hideSignOnImageView()
            }
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

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollToNearestVisibleCollectionViewCell()
        }
    }
}
