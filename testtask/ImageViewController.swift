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
    
    @IBAction func sendEmail(sender: AnyObject) {

        if( MFMailComposeViewController.canSendMail() ) {
            print("Can send email.")
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            mailComposer.setToRecipients(["test@test.com"])
            mailComposer.setSubject("Test")
            mailComposer.setMessageBody(TestData.sharedInstance.names[number!], isHTML: false)
            mailComposer.addAttachmentData(NSData(contentsOfURL: NSURL(string: TestData.sharedInstance.bigImgsURLs[number!])!)!, mimeType: "image/jpeg", fileName: "pict")
            self.presentViewController(mailComposer, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    var number : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadIndicator.startAnimating()
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            let image = UIImage(data: NSData(contentsOfURL: NSURL(string: TestData.sharedInstance.bigImgsURLs[self.number!])!)!)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.img!.image = image
                self.loadIndicator.stopAnimating()
            })
        })
        // Do view setup here.
    }
    
    
}
