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
        let url = NSURL(string: "http://www.xiag.ch/share/testtask/list.json")!
        let data = NSData(contentsOfURL: url)
        if data != nil {
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                print(jsonData)
                
                for i in 0..<jsonData.count! {
                    if let block = jsonData[i] as? [String : AnyObject]{
                        if let name  = block["name"] as? String {
                            self.names.append(name)
                        }
                        if let tn = block["url_tn"] as? String {
                            self.tnURLs.append(tn)
                        }
                        if let big = block["url"] as? String {
                            self.bigImgsURLs.append(big)
                        }
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
