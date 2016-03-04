//
//  CellForPicture.swift
//  testtask
//
//  Created by Admin on 02.03.16.
//  Copyright © 2016 Khlebnikov. All rights reserved.
//

import UIKit

class CellForPicture: UICollectionViewCell {

    @IBOutlet weak var previewPic: UIImageView!
    @IBOutlet weak var nameOfPicture: UILabel!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    var number = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(number : Int){
        nameOfPicture.text = TestData.sharedInstance.names[number]
        previewPic.image = nil
        loadIndicator.startAnimating()
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            let image = UIImage(data: NSData(contentsOfURL: NSURL(string: TestData.sharedInstance.tnURLs[number])!)!)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.previewPic.image = image
                self.loadIndicator.stopAnimating()
            })
        })
        
        self.number = number
    }

}
