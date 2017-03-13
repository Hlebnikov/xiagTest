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
    @IBOutlet weak var nameLabelBgView : UIView!
    
    static let nibName = "CellForPicture"
    
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        return queue
    }()
    
    var info : XTImageInfo!
    
    func config(_ info : XTImageInfo){
        self.info = info
        loadIndicator.startAnimating()
        nameOfPicture.text = info.name
        previewPic.image = UIImage(named: "default-placeholder")
        let urlString = info.smallImageUrl
        getImage(fromUrl: urlString) { (image) in
            self.previewPic.image = image
            self.loadIndicator.stopAnimating()
        }
    }
    
    func getImage(fromUrl url: String, complition: @escaping (UIImage)->()){
        if let cachedImage = ImageCache.sharedInstance.getImage(withKey: url){
            complition(cachedImage)
        }else{
            self.downloadQueue.addOperation {
                if let imageData = try? Data(contentsOf: URL(string: url)!){
                    if let image = UIImage(data: imageData){
                        ImageCache.sharedInstance.save(image: image, forKey: url)
                        OperationQueue.main.addOperation{
                            complition(image)
                        }
                    }
                }
            }
        }
    }
    
}
