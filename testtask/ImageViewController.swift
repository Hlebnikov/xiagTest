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

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel : UILabel!
    
    var imageInfo : XTImageInfo!
    var imageData : Data?
    
    @IBAction func close(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadIndicator.startAnimating()
        loadImage()
        let sendEmailButton = UIBarButtonItem(image: #imageLiteral(resourceName: "mail"), style: .done, target: self, action: #selector(sendEmail))
        self.navigationItem.setRightBarButton(sendEmailButton, animated: false)
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func loadImage(){
        self.nameLabel.text = self.imageInfo.name
        
        let downloadQueue = DispatchQueue(label: "xiag.test.downloadBig", qos: .userInitiated)
        downloadQueue.async(execute: {
            if let imageData = try? Data(contentsOf: URL(string: self.imageInfo.bigImageUrl)!){
                self.imageData = imageData
                let image = UIImage(data: imageData)
                DispatchQueue.main.async(execute: { () -> Void in
                    self.imageView.image = image
                    self.loadIndicator.stopAnimating()
                })
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
}

extension ImageViewController: MFMailComposeViewControllerDelegate{
    @IBAction func sendEmail(){
        if(MFMailComposeViewController.canSendMail()) {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients(["test@test.com"])
            mailComposer.setSubject("Test")
            
            if let imageData = self.imageData{
                let imageName = imageInfo.name
                mailComposer.setMessageBody(imageName, isHTML: false)
                mailComposer.addAttachmentData(imageData, mimeType: "image/jpeg", fileName: imageName)
                
                self.present(mailComposer, animated: true, completion: nil)
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}
