//
//  ViewController.swift
//  CardScanner
//
//  Created by ZLMac on 15-4-15.
//  Copyright (c) 2015年 lgwh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CardIOPaymentViewControllerDelegate {

    @IBOutlet weak var reslutLabel: UILabel!
    @IBAction func startScan(sender: UIButton) {
        var cardvc = CardIOPaymentViewController(paymentDelegate: self)
        
        cardvc.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        presentViewController(cardvc, animated: true, completion: nil)
        
    }
    
    //
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        reslutLabel.text = "已经取消扫描"
        paymentViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        if let card = cardInfo {
            reslutLabel.text = "卡号:\(card.cardNumber)\n过期\(card.expiryYear)年\(card.expiryMonth)月\nCVV:\(card.cvv)"
        }
        paymentViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

