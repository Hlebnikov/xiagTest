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
    
    func config(_ number : Int){
        nameOfPicture.text = TestData.sharedInstance.names[number]
        previewPic.image = nil
        loadIndicator.startAnimating()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            let image = UIImage(data: try! Data(contentsOf: URL(string: TestData.sharedInstance.tnURLs[number])!))
            DispatchQueue.main.async(execute: { () -> Void in
                self.previewPic.image = image
                self.loadIndicator.stopAnimating()
            })
        })
        
        self.number = number
    }

}
