//
//  PaymentCostController.swift
//  Kids-LearnWithFun1
//
//  Created by Sheetal Ghatkar on 07/01/21.
//  Copyright © 2021 sheetal shinde. All rights reserved.
//

import UIKit
import StoreKit
//import SwiftyStoreKit
class PaymentCostController: UIViewController ,SKProductsRequestDelegate, SKPaymentTransactionObserver {
    //CustomLiceneProtocol
    @IBOutlet weak var lblCostTitle: UILabel!
    @IBOutlet weak var btnRestore: UIButton!
    @IBOutlet weak var lblAlredyPurchased: UILabel!
    @IBOutlet weak var  widthHome: NSLayoutConstraint!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var heightHomeBtn: NSLayoutConstraint!
    //----------------------------------------
    //New
    @IBOutlet weak var viewBgYearly: UIView!
    
    @IBOutlet weak var viewYearly: UIView!
    @IBOutlet weak var viewMonthly: UIView!

    
    @IBOutlet weak var lblOneTimeTitle: UILabel!
    @IBOutlet weak var lblOneTimePayment: UILabel!
    @IBOutlet weak var lblOneTimePaymentPrice: UILabel!
    @IBOutlet weak var btnBuy: UIButton!

    
    @IBOutlet weak var lblPrivacyPolicy: UILabel!

//    var licenseAgreementVC : CustomLiceneModelController?

    @IBOutlet weak var viewTrasperentDisabled: UIView!

   // var product_id = "com.mobiapps360.LearnNature.YearlyAutoRenew"
    var selectedProductId = CommanArray.productId_OneTime
    var isAutoRenewPurchase = true
    var selectedSubscriptionPrice = CommanArray.productId_OneTime_Price

    let defaults = UserDefaults.standard
    
    //Restore Status
    var restoreStatus = 0
    //0 Not purchased
    //1 Purchased
    //2 Error Occurred

    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        lblAlredyPurchased.text = "Already Purchased?"
        lblCostTitle.text = "Unlock Premium Features"
        btnRestore.setTitle("Restore", for: .normal)

        /*var textBuyOneTime = NSMutableAttributedString(string:"One-time Payment" + "    " + "$15")
        textBuyOneTime.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 20, weight: .bold),range: NSRange(location: 16, length: (textBuyOneTime.length - 16)))
        btnBuyOneTime.setAttributedTitle(textBuyOneTime, for: .normal)*/
                
        btnRestore.setTitleColor(CommanArray.redBorderColor, for: .normal)
        
        //Views
        viewBgYearly.backgroundColor = CommanArray.greenBgColor
        viewBgYearly.layer.borderColor = CommanArray.redBorderColor.cgColor

        
        //Buttons
        btnBuy.setTitle("Buy", for: .normal)
        
        btnBuy.setTitleColor(CommanArray.redBorderColor, for: .normal)
        
        //Label
        lblOneTimeTitle.text = "One-Time Deal"
        lblOneTimePayment.text = "One Time Payment"
        lblOneTimePaymentPrice.text = "$3.99"
        
        if !(UIDevice.current.hasNotch) {
            widthHome.constant = 40
        }
        
        btnRestore.layer.borderColor = CommanArray.redBorderColor.cgColor
        btnBuy.layer.borderColor = CommanArray.redBorderColor.cgColor

//        viewTrasperentDisabled.isHidden = false
//        licenseAgreementVC = CustomLiceneModelController(nibName: "CustomLiceneModelController", bundle: nil)
//        licenseAgreementVC?.delegateCustomLicene = self
//        self.view.addSubview(licenseAgreementVC?.view ?? UIView())
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.privacyLinkClicked(sender:)))
        lblPrivacyPolicy.isUserInteractionEnabled = true
        lblPrivacyPolicy.addGestureRecognizer(tap)
        
        if UIScreen.main.bounds.height < 820 {
            heightHomeBtn.constant = 42
        }
    }
    
//    func removeViewFromApp() {
//        viewTrasperentDisabled.isHidden = true
//        licenseAgreementVC?.view.removeFromSuperview()
//    }

    @IBAction func funcHomeBtnClick(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    @IBAction func funcPaymentBtnClick(_ sender: Any) {
        buyConsumable()
    }
    
    @IBAction func funcRestoreBtnClick(_ sender: Any) {
      print("Restore clicked.")
      if Reachability.isConnectedToNetwork() {
        self.viewTrasperentDisabled.isHidden = false
        let appleValidator = AppleReceiptValidator(service: .sandbox, sharedSecret: CommanArray.secretKey)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productId = CommanArray.productId_OneTime
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: productId,
                    inReceipt: receipt)
                    
                switch purchaseResult {
                case .purchased(let receiptItem):
                    print("\(productId) is purchased: \(receiptItem)")
                    self.defaults.set(true, forKey: "IsPrimeUser")
                    self.viewTrasperentDisabled.isHidden = true
                    let alert = UIAlertController(title: "", message: "Product restored successfully.", preferredStyle: UIAlertController.Style.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                case .notPurchased:
                    print("The user has never purchased \(productId)")
                    self.viewTrasperentDisabled.isHidden = true
                    self.defaults.set(false, forKey: "IsPrimeUser")
                    let alert = UIAlertController(title: "", message: "No active subscription found.", preferredStyle: UIAlertController.Style.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                    }))
                    self.present(alert, animated: true, completion: nil)

                }
            case .error(let error):
                print("Receipt verification failed: \(error)")
                self.viewTrasperentDisabled.isHidden = true
                let alert = UIAlertController(title: "", message: "Error occured. Error code Err01: \(error)", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
      } else {
        let alert = UIAlertController(title: "", message: "No Internet connection.", preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
            self.viewTrasperentDisabled.isHidden = true
        }))
        self.present(alert, animated: true, completion: nil)

    }
    }
}

extension PaymentCostController {
    func buyConsumable(){
        print("About to fetch the products");
        // We check that we are allow to make the purchase.
        if Reachability.isConnectedToNetwork() {
            self.viewTrasperentDisabled.isHidden = false
            if (SKPaymentQueue.canMakePayments())
            {
                let productsRequest = SKProductsRequest(productIdentifiers: Set(arrayLiteral: self.selectedProductId))
                productsRequest.delegate = self
                productsRequest.start()
                print("Fething Products")
            }else{
                print("can't make purchases");
            }
        } else {

            let alert = UIAlertController(title: "", message: "No Internet connection.", preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                self.viewTrasperentDisabled.isHidden = true
            }))
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    // Helper Methods
    
    func buyProduct(product: SKProduct){
        print("Sending the Payment Request to Apple")
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
        
    }
    

    // Delegate Methods for IAP
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("got the request from Apple")
        var isProductFound = false
        let count : Int = response.products.count
        if (count>0) {
            print("Success@@@@@@@")
            for getProductId in response.products {
                let validProduct: SKProduct = getProductId as SKProduct
                if (validProduct.productIdentifier == selectedProductId) {
                    isProductFound = true
                    print(validProduct.localizedTitle)
                    print(validProduct.localizedDescription)
                    print(validProduct.price)
                    buyProduct(product: validProduct)
                }
            }
            if !isProductFound {
                print("Product not found.")
            }
        } else {
            print("Nothing")
        }
    }
    
    
    func request(request: SKRequest!, didFailWithError error: NSError!) {
        print("La vaina fallo");
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("Received Payment Transaction Response from Apple");
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .purchased:
                    print("Product Purchased");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    self.viewTrasperentDisabled.isHidden = true
                    self.defaults.set(true, forKey: "IsPrimeUser")
                    let alert = UIAlertController(title: "", message: "Payment transaction Successful.", preferredStyle: UIAlertController.Style.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    break;
                case .failed:
                    print("Purchased Failed");
                    self.defaults.set(false, forKey: "IsPrimeUser")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
//                    self.navigationController?.popViewController(animated: true)
                    let alert = UIAlertController(title: "", message: "Payment transaction failed. Please Try again.", preferredStyle: UIAlertController.Style.alert)
                    self.viewTrasperentDisabled.isHidden = true
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                    }))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    break;
                case .restored:
                    print("Already Purchased")
                    //self.verifyReciptOfPayment()
                    self.defaults.set(true, forKey: "IsPrimeUser")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    let alert = UIAlertController(title: "", message: "Product restored successfully.", preferredStyle: UIAlertController.Style.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)

                    break;
                default:
                    break;
               }
            }
          }
      
        
        
        }

//        //If an error occurs, the code will go to this function
//        func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
//            print("transactions restored error")
//            self.viewTrasperentDisabled.isHidden = true
//            let alert = UIAlertController(title: "", message: "Unable to restore now. Please try after some time", preferredStyle: UIAlertController.Style.alert)
//            // add an action (button)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
//            }))
//            self.present(alert, animated: true, completion: nil)
//
//            //Handle Error
//        }
    func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue) {
        print("transactions restored")
            for transaction in queue.transactions {
                let t: SKPaymentTransaction = transaction
                let prodID = t.payment.productIdentifier as String
                if prodID == "product ID" {
                    print("action for restored")
                    queue.finishTransaction(t)
                    //code here what to restore
            }
        }
    }
    //Step 1 Call from button Restore Purchase
    func restore() {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()

    }
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("restoreCompletedTransactionsFailedWithError")
    }

    @objc func privacyLinkClicked(sender:UITapGestureRecognizer) {
        openUrl(urlStr: "https://mobiapps360.com/privacy")
    }

    func openUrl(urlStr: String!) {
        if let url = URL(string:urlStr), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
