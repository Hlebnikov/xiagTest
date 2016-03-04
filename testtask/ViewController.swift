//
//  ViewController.swift
//  testtask
//
//  Created by Admin on 02.03.16.
//  Copyright © 2016 Khlebnikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var imgIsShowing = false
    var filteredData : [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData != [] ? filteredData.count : TestData.sharedInstance.names.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? CellForPicture
        
        if (cell != nil) {
            if filteredData == [] {
                cell!.config(indexPath.row)
            } else {
                cell!.config(filteredData[indexPath.row])
            }
            return cell!
        } else {
            return UICollectionViewCell()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSequence" {
            let svc = segue.destinationViewController as? ImageViewController
            if let cell = sender as? CellForPicture {
                svc!.number = cell.number
            }
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {

        filteredData = []
        if searchBar.text != "" {
            for i in 0..<TestData.sharedInstance.names.count {
                if let _ = TestData.sharedInstance.names[i].rangeOfString(searchBar.text!, options: .CaseInsensitiveSearch) {
                    filteredData.append(i)
                }
            }
        }
        print(filteredData)
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        filteredData = []
        collectionView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredData = []
            collectionView.reloadData()
        }
    }


}

