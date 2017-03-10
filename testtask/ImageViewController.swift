//
//  ImageViewController.swift
//  testtask
//
//  Created by Admin on 03.03.16.
//  Copyright © 2016 Khlebnikov. All rights reserved.
//

import UIKit
import Foundation
import MessageUI

class ImageViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var img : UIImageView?
    @IBOutlet weak var sendButton : UIButton?
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    var number : Int?
    var imageData : Data?
    
    @IBAction func sendEmail(_ sender: AnyObject) {

        if( MFMailComposeViewController.canSendMail() ) {
            print("Can send email.")
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            mailComposer.setToRecipients(["test@test.com"])
            mailComposer.setSubject("Test")
            mailComposer.setMessageBody(TestData.sharedInstance.names[number!], isHTML: false)
            mailComposer.addAttachmentData(imageData!, mimeType: "image/jpeg", fileName: "pict")
            self.present(mailComposer, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadIndicator.startAnimating()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            self.imageData = try! Data(contentsOf: URL(string: TestData.sharedInstance.bigImgsURLs[self.number!])!)
            let image = UIImage(data: self.imageData!)
            DispatchQueue.main.async(execute: { () -> Void in
                self.img!.image = image
                self.loadIndicator.stopAnimating()
            })
        })
        
    }
    
    
}
