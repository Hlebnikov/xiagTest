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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData != [] ? filteredData.count : TestData.sharedInstance.names.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CellForPicture
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSequence" {
            let svc = segue.destination as? ImageViewController
            if let cell = sender as? CellForPicture {
                svc!.number = cell.number
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        filteredData = []
        if searchBar.text != "" {
            for i in 0..<TestData.sharedInstance.names.count {
                if let _ = TestData.sharedInstance.names[i].range(of: searchBar.text!, options: .caseInsensitive) {
                    filteredData.append(i)
                }
            }
        }
        print(filteredData)
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredData = []
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredData = []
            collectionView.reloadData()
        }
    }


}

