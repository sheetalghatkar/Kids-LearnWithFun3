//
//  AppConstant.swift
//  Kids-LearnWithFun3
//
//  Created by sheetal shinde on 30/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class CommanArray {
    static var fruitsImageArray: [UIImage] = [
        UIImage(named: "Mango.png")!,
        UIImage(named: "Custard Apple.png")!,
        UIImage(named: "Grapes.png")!,
        UIImage(named: "Apple.png")!,
        UIImage(named: "Guava.png")!,
        UIImage(named: "Kiwi.png")!,
        UIImage(named: "Orange.png")!,
        UIImage(named: "Papaya.png")!,
        UIImage(named: "Pineapple.png")!,
        UIImage(named: "Strawberry.png")!,
        UIImage(named: "Pomegranate.png")!,
        UIImage(named: "Watermelon.png")!,
        UIImage(named: "Jackfruit.png")!,
        UIImage(named: "Banana.png")!,
        UIImage(named: "Chickoo.png")!,
        UIImage(named: "Pear.png")!,
        UIImage(named: "Muskmelon.png")!
    ]
    static var fruitsNameArray: [String] = ["Mango","Custard Apple","Grapes","Apple","Guava","Kiwi","Orange","Papaya","Pineapple","Strawberry","Pomegranate","Watermelon","Jackfruit","Banana","Chickoo","Pear","Muskmelon"]
    //------------------------------------------------------------------------
    static var vegetablesImageArray: [UIImage] = [
        UIImage(named: "Onion.png")!,
        UIImage(named: "Potato.png")!,
        UIImage(named: "Spinach.png")!,
        UIImage(named: "Pumpkin.png")!,
        UIImage(named: "Raddish.png")!,
        UIImage(named: "Spring Onion.png")!,
        UIImage(named: "Tomato.png")!,
        UIImage(named: "Green Chilli.png")!,
        UIImage(named: "Garlic.png")!,
        UIImage(named: "Brinjal.png")!,
        UIImage(named: "Green Peas.png")!,
        UIImage(named: "Ginger.png")!,
        UIImage(named: "Lady Finger.png")!,
        UIImage(named: "Fenugreek Leaves.png")!,
        UIImage(named: "Cucumber.png")!,
        UIImage(named: "Coriander.png")!,
        UIImage(named: "Cauliflower.png")!,
        UIImage(named: "Curry Leaves.png")!,
        UIImage(named: "Carrot.png")!,
        UIImage(named: "Cabbage.png")!,
        UIImage(named: "Beetroot.png")!
    ]
    static var vegetablesNameArray: [String] = ["Onion","Potato",
                                                     "Spinach","Pumpkin","Raddish","Spring Onion","Tomato","Green Chilli","Garlic","Brinjal","Green Peas","Ginger","Lady Finger","Fenugreek Leaves","Cucumber","Coriander","Cauliflower","Curry Leaves","Carrot","Cabbage","Beetroot"]
    //------------------------------------------------------------------------
    static var grainsImageArray: [UIImage] = [
        UIImage(named: "Wheat.png")!,
        UIImage(named: "Rice.png")!,
        UIImage(named: "Pearl Millet.png")!,
        UIImage(named: "Sorghum Millet.png")!,
        UIImage(named: "Bengal Gram Lentil.png")!,
        UIImage(named: "Brown Lentil.png")!,
        UIImage(named: "Red Lentil.png")!,
        UIImage(named: "Cowpea Seeds.png")!,
        UIImage(named: "Mung Beans.png")!,
        UIImage(named: "Oats.png")!,
        UIImage(named: "Soya Chunks.png")!,
        UIImage(named: "Sago.png")!,
        UIImage(named: "Kidney Beans.png")!,
        UIImage(named: "Black Chickpeas.png")!,
        UIImage(named: "White Chickpeas.png")!,
        UIImage(named: "Foxnuts.png")!,
        UIImage(named: "Corn.png")!
    ]
    static var grainsNameArray: [String] = ["Wheat",
        "Rice","Pearl Millet","Sorghum Millet","Bengal Gram Lentil","Brown Lentil","Red Lentil","Cowpea Seeds","Mung Beans","Oats","Soya Chunks","Sago","Kidney Beans","Black Chickpeas","White Chickpeas","Foxnuts","Corn"]
    //------------------------------------------------------------------------
    static var spicesImageArray: [UIImage] = [
        UIImage(named: "Cumin.png")!,
        UIImage(named: "Turmeric Powder.png")!,
        UIImage(named: "Red Chilli Powder.png")!,
        UIImage(named: "Asafoetida.png")!,
        UIImage(named: "Cinnamon.png")!,
        UIImage(named: "Cloves.png")!,
        UIImage(named: "Black Stone Flower.png")!,
        UIImage(named: "Bay Leaves.png")!,
        UIImage(named: "Black Pepper.png")!,
        UIImage(named: "Cardamom.png")!,
        UIImage(named: "Mustard Seeds.png")!,
        UIImage(named: "Carom Seeds.png")!,
        UIImage(named: "Coriander Seeds.png")!,
        UIImage(named: "Nutmeg.png")!,
        UIImage(named: "Star Anise.png")!,
        UIImage(named: "Sesame.png")!,
        UIImage(named: "Saffron.png")!,
        
    ]
    static var spicesNameArray: [String] = ["Cumin","Turmeric Powder","Red Chilli Powder","Asafoetida","Cinnamon","Cloves","Black Stone Flower","Bay Leaves","Black Pepper","Cardamom","Mustard Seeds","Carom Seeds", "Coriander Seeds","Nutmeg","Star Anise","Sesame", "Saffron"]
    //------------------------------------------------------------------------
    static var status_Sign_Array = [
        UIImage(named: "Wrong-Sign.png")!,
        UIImage(named: "Right-Sign.png")!
    ]
    static var imageRadioCheck = UIImage(named: "radio_check.png")
    static var imageRadioUncheck = UIImage(named: "radio_uncheck.png")
    static var imgCancelSubscription = UIImage(named: "PaymentDetail.png")!
    static var imgCancelSubscription1 = UIImage(named: "PaymentDetail-1.png")!

    static var homeImgSoundOn = UIImage(named: "Sound-On_home.png")!
    static var homeImgSoundOff = UIImage(named: "Sound-Off_home.png")!
    
    
    static var imgSoundOn = UIImage(named: "Sound-On.png")!
    static var imgSoundOff = UIImage(named: "Sound-Off.png")!


    
    static var settingBgColor = UIColor(red: (113/255), green: (200/255), blue: (92/255), alpha: 1.0)
    static var redBorderColor = UIColor(red: (222/255), green: (50/255), blue: (36/255), alpha: 1.0)
    static var greenBorderColor = UIColor(red: (113/255), green: (53/255), blue: (40/255), alpha: 1.0)
    static var paymentBtnTextColor = UIColor(red: (130/255), green: (188/255), blue: (53/255), alpha: 1.0)
    static var greenBgColor = UIColor(red: (127/255), green: (183/255), blue: (53/255), alpha: 1.0)
    
    //Colors
    static var paymentModeBgColor = UIColor(red: (130/255), green: (188/255), blue: (53/255), alpha: 1.0)


    //Related to review and rating
    static let app_AppStoreLink = URL(string: "https://apps.apple.com/app/id1554806857")
        
    //Related to InAppPurchase
    static var environment = AppleReceiptValidator.VerifyReceiptURLType.production
    static var secretKey = "921c477cb41f4a6b839e16f53a600c04"
    
    static var productId_Year_Auto_Recurring = "com.mobiapps360.LearnNaturalFood.YearlyAutoRecurring"
    static var productId_Year_Non_Recurring = "com.mobiapps360.LearnNaturalFood.YearlyNonRecurring"
    static var productId_Month_Auto_Recurring = "com.mobiapps360.LearnNaturalFood.MonthlyAutoRecurring"
    static var productId_Month_Non_Recurring = "com.mobiapps360.LearnNaturalFood.MonthlyNonRecurring"
    static var timerForAds = 12.0
    
    
    //Related to Ads Production
    /*static var Banner_AdUnitId = "ca-app-pub-7546454767986772/5984207231"
    static var Interstitial_AdUnitId = "ca-app-pub-7546454767986772/8418798884"
    static var Ad_App_ID = "ca-app-pub-7546454767986772~4750166558"*/

    

//    //Related to Ads Sandbox/Test
    static var Banner_AdUnitId = "ca-app-pub-3940256099942544/2934735716"
    static var Interstitial_AdUnitId = "ca-app-pub-3940256099942544/4411468910"
    static var Ad_App_ID = "ca-app-pub-3940256099942544~1458002511"
    
    
}

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
/**
 * Check if internet connection is available
 */
public class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}

extension UIWindow {
    /// Returns the currently visible view controller if any reachable within the window.
    public var visibleViewController: UIViewController? {
        return UIWindow.visibleViewController(from: rootViewController)
    }

    /// Recursively follows navigation controllers, tab bar controllers and modal presented view controllers starting
    /// from the given view controller to find the currently visible view controller.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to start the recursive search from.
    /// - Returns: The view controller that is most probably visible on screen right now.
    public static func visibleViewController(from viewController: UIViewController?) -> UIViewController? {
        switch viewController {
        case let navigationController as UINavigationController:
            return UIWindow.visibleViewController(from: navigationController.visibleViewController ?? navigationController.topViewController)

        case let tabBarController as UITabBarController:
            return UIWindow.visibleViewController(from: tabBarController.selectedViewController)

        case let presentingViewController where viewController?.presentedViewController != nil:
            return UIWindow.visibleViewController(from: presentingViewController?.presentedViewController)

        default:
            return viewController
        }
    }
}

