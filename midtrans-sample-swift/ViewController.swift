//
//  ViewController.swift
//  midtrans-sample-swift
//
//  Created by Zaki Ibrahim on 11/10/19.
//  Copyright © 2019 Zaki Ibrahim. All rights reserved.
//

import UIKit
import MidtransKit
import WebKit

class ViewController: UIViewController, MidtransUIPaymentViewControllerDelegate {
    
    @IBOutlet weak var snapTokenField: UITextField!
    
    
    func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentPending result: MidtransTransactionResult!) {
        
    }
    
    func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentDeny result: MidtransTransactionResult!) {
        
    }
    
    func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentSuccess result: MidtransTransactionResult!) {
        
    }
    
    func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentFailed error: Error!) {
        
    }
    
    func paymentViewController_paymentCanceled(_ viewController: MidtransUIPaymentViewController!) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
        payTransaction()
    }
    
    /*
     * Show snap with detail request from mobile SDK.
     * The mobile SDK will request the snap token with detail to merchant backend.
     * Details request: https://mobile-docs.midtrans.com/#prepare-transaction-details
     */
    func payTransaction() {
        
        let itemDetail1 = MidtransItemDetail.init(itemID: "ID001", name: "Cendol", price: 20000, quantity: 2)
        
        let itemDetai2 = MidtransItemDetail.init(itemID: "ID002", name: "Centing", price: 5000, quantity: 1)
        
        let itemDetai3 = MidtransItemDetail.init(itemID: "ID003", name: "Cenang", price: 5000, quantity: 1)
        
        let itemDetai4 = MidtransItemDetail.init(itemID: "ID004", name: "Cendil", price: 5000, quantity: 1)
        
        let itemDetai5 = MidtransItemDetail.init(itemID: "ID005", name: "Wajik", price: 5000, quantity: 1)
        
        let customerDetail = MidtransCustomerDetails.init(
            firstName: "Zaki",
            lastName: "Ibrahim",
            email: "zaki@mailnesia.com",
            phone: "22222222",
            shippingAddress: MidtransAddress.init(
                firstName: "Zaki",
                lastName: "Ibrahim",
                phone: "22222222",
                address: "Pasaraya Blok M",
                city: "JakSel",
                postalCode: "10122",
                countryCode: "IDN"
            ), billingAddress: MidtransAddress.init(
                firstName: "Zaki",
                lastName: "Ibrahim",
                phone: "22222222",
                address: "Pasaraya Blok M",
                city: "JakSel",
                postalCode: "10122",
                countryCode: "IDN"
            ))
        
        let timestamp = Date().timeIntervalSince1970
        let transactionDetail = MidtransTransactionDetails.init(orderID: "iOS-SDK-" + String(timestamp), andGrossAmount: 60000)
        MidtransMerchantClient.shared().requestTransactionToken(with: transactionDetail!,
            itemDetails: [ itemDetail1!, itemDetai2!, itemDetai3!, itemDetai4!,itemDetai5!],
            customerDetails: customerDetail)
        { (response, error) in if (response != nil) {
                //show PaymentUI
                let vc = MidtransUIPaymentViewController.init(token: response)
                vc?.paymentDelegate = self
                self.present(vc!, animated: true, completion: nil)
            } else {
                //handle
                print("error \(String(describing: error))")
            }
        }
    }
    
//    func initializeMidtransSDK() {
//        MidtransConfig.shared().setClientKey(
//            "SB-Mid-client-nKsqvar5cn60u2Lv",
//            environment: .sandbox,
//            merchantServerURL:"https://sample-demo-dot-midtrans-support-tools.et.r.appspot.com/"
//        )
//        MidtransNetworkLogger.shared()?.startLogging()
//    }
    
    /*
     * This method open Payment screen with manual snap token request from your backend
     * without Midtrans SDK. You can find the details of request from this page
     * Snap Docs: https://snap-docs.midtrans.com/#request-body-json-parameter
    */
    func payWithToken(snapToken: String){
        MidtransConfig.shared().callbackSchemeURL = "myApp://";
        MidtransConfig.shared().shopeePayCallbackURL = "myApp://"
        
        MidtransMerchantClient.shared().requestTransacation(withCurrentToken: snapToken) { (response, error) in
            if (response != nil) {
                //show Payment UI
                let vc = MidtransUIPaymentViewController.init(token: response)
                vc?.paymentDelegate = self
                self.present(vc!, animated: true, completion: nil)
            } else {
            //handle error
                print("error \(String(describing: error))")
            }
        }
    }
    
    
    @IBAction func snapManualToken(_ sender: UIButton) {
        MidtransConfig.shared().callbackSchemeURL = "myApp://";
        MidtransConfig.shared().shopeePayCallbackURL = "myApp://"
        
        let snapToken: String = snapTokenField.text!
        
        MidtransMerchantClient.shared().requestTransacation(withCurrentToken: snapToken) { (response, error) in
            if (response != nil) {
                //show Payment UI
                let vc = MidtransUIPaymentViewController.init(token: response)
                vc?.paymentDelegate = self
                self.present(vc!, animated: true, completion: nil)
            } else {
                //handle error
                print("error \(String(describing: error))")
            }
        }
    }
}
