//
//  ViewController.swift
//  testtask
//
//  Created by Admin on 02.03.16.
//  Copyright © 2016 Khlebnikov. All rights reserved.
//

import UIKit

let kPictureCellId = "cell"
let kShowPictureSegue = "showImage"

class GalleryViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var imgIsShowing = false
    var filteredData = [XTImageInfo]()
    
    override func viewDidLoad() {
        collectionView.register(UINib(nibName: CellForPicture.nibName, bundle: nil), forCellWithReuseIdentifier: kPictureCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kShowPictureSegue {
            if let svc = segue.destination as? ImageViewController {
                if let cell = sender as? CellForPicture {
                    svc.imageInfo = cell.info
                }
            }
        }
    }
}

//MARK: - Search bar delegate
extension GalleryViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredData = []
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredData = []
            collectionView.reloadData()
        }
        
        filteredData = TestData.sharedInstance.imageInfos.filter{
            $0.name.range(of: searchText, options: .caseInsensitive) != nil
        }
        collectionView.reloadData()
    }
    
}

//MARK: - Collection view delegate
extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count > 0 ? filteredData.count : TestData.sharedInstance.imageInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPictureCellId, for: indexPath) as? CellForPicture {
            if filteredData.count == 0 {
                cell.config(TestData.sharedInstance.imageInfos[indexPath.row])
            } else {
                cell.config(filteredData[indexPath.row])
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: kShowPictureSegue, sender: cell)
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let colums : CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 3 : 5

        return CGSize(width: width/colums, height: width/colums)
    }
}

