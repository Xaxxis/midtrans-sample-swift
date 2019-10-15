//
//  ViewController.swift
//  midtrans-sample-swift
//
//  Created by Zaki Ibrahim on 11/10/19.
//  Copyright © 2019 Zaki Ibrahim. All rights reserved.
//

import UIKit
import MidtransKit


class ViewController: UIViewController {
    
    let idRand = UUID().uuidString

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let itemDetail1 = MidtransItemDetail.init(itemID: "ID001", name: "Cendol", price: 20000, quantity: 2)
    
    let itemDetai2 = MidtransItemDetail.init(itemID: "ID002", name: "Centing", price: 5000, quantity: 1)
    
    let itemDetai3 = MidtransItemDetail.init(itemID: "ID003", name: "Cenang", price: 5000, quantity: 1)
    
    let itemDetai4 = MidtransItemDetail.init(itemID: "ID004", name: "Cendil", price: 5000, quantity: 1)
    
    let itemDetai5 = MidtransItemDetail.init(itemID: "ID005", name: "Wajik", price: 5000, quantity: 1)
    
    let customerDetail = MidtransCustomerDetails.init(firstName: "Zaki", lastName: "Ibrahim", email: "zaki@mailnesia.com", phone: "22222222", shippingAddress: MidtransAddress.init(firstName: "Zaki", lastName: "Ibrahim", phone: "22222222", address: "Pasaraya Blok M", city: "JakSel", postalCode: "10122", countryCode: "IDN"), billingAddress: MidtransAddress.init(firstName: "Zaki", lastName: "Ibrahim", phone: "22222222", address: "Pasaraya Blok M", city: "JakSel", postalCode: "10122", countryCode: "IDN"))

    
    @IBAction func onButtonClick(_ sender: Any) {
        let transactionDetail = MidtransTransactionDetails.init(orderID: UUID.init().uuidString, andGrossAmount: 60000)
        
        MidtransMerchantClient.shared().requestTransactionToken(with: transactionDetail!, itemDetails: [itemDetail1!,itemDetai2!,itemDetai3!,itemDetai4!,itemDetai5!], customerDetails: customerDetail) { (response, error) in
        
            if (response != nil) {
            //show Payment UI
                let vc = MidtransUIPaymentViewController.init(token: response)
                self.present(vc!, animated: true, completion: nil)

                }
            else {
            //handle error
            }
        }
    }
    

    func showToast(message : String) {
    
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }


}

