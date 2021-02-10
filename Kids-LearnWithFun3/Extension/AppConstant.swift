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
    
    static var settingBgColor = UIColor(red: (113/255), green: (200/255), blue: (92/255), alpha: 1.0)
    static var redBorderColor = UIColor(red: (222/255), green: (50/255), blue: (36/255), alpha: 1.0)
    static var greenBorderColor = UIColor(red: (113/255), green: (53/255), blue: (40/255), alpha: 1.0)
    static var paymentBtnTextColor = UIColor(red: (37/255), green: (160/255), blue: (187/255), alpha: 1.0)
    static var greenBgColor = UIColor(red: (127/255), green: (183/255), blue: (53/255), alpha: 1.0)

    //Related to review and rating
    static let app_AppStoreLink = URL(string: "https://apps.apple.com/app/id1551996699")
    static var productId_OneTime = "com.mobiapps360.LearnNaturalFood.NonConsumable"
    static var productId_OneTime_Price = "$3.99"
    
    //Related to InAppPurchase
    static var environment = AppleReceiptValidator.VerifyReceiptURLType.production
    static var secretKey = "81d5ad37b4954dc89fc951f7cfa22507"
    
    
    static var Kidoz_Publisher_ID: String = "14473"
    static var Kidoz_Publisher_token: String = "HXpnS8JiAsO55xxVR97UyElgRU8KHtDJ"

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
class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var status:Bool = false
        let url = NSURL(string: "http://google.com")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "HEAD"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        var response1:URLResponse?
        
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            response1 = response
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        if let httpResponse = response1 as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                status = true
            }
        }
        return status
      }
}

