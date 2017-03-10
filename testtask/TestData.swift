//
//  TestData.swift
//  testtask
//
//  Created by Admin on 03.03.16.
//  Copyright © 2016 Khlebnikov. All rights reserved.
//

import Foundation

class TestData {
    
    static let sharedInstance = TestData()
    
    var names = [String]()
    var tnURLs = [String]()
    var bigImgsURLs = [String]()
    
    init(){
        let url = URL(string: "http://www.xiag.ch/share/testtask/list.json")!
        let data = try? Data(contentsOf: url)
        if data != nil {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSArray
                print(jsonData)
                
                for i in 0..<(jsonData as AnyObject).count! {
                    if let block = jsonData[i] as? [String : String]{
                        self.names.append(block["name"]!)
                        self.tnURLs.append(block["url_tn"]!)
                        self.bigImgsURLs.append(block["url_tn"]!)
                    }
                }
            } catch {
                print("error serializing JSON: \(error)")
            }
        }
        print(names)
        print(tnURLs)
        print(bigImgsURLs)
    }
}
