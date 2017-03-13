//
//  TestData.swift
//  testtask
//
//  Created by Admin on 03.03.16.
//  Copyright © 2016 Khlebnikov. All rights reserved.
//

import Foundation

struct XTImageInfo{
    let name : String
    let smallImageUrl: String
    let bigImageUrl: String
}

class TestData {
    static let sharedInstance = TestData()
    
    var imageInfos = [XTImageInfo]()

    init(){
        let url = URL(string: "http://www.xiag.ch/share/testtask/list.json")!
        if let data = try? Data(contentsOf: url){
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray

                for block in jsonData{
                    if let block = block as? [String : String]{
                        let name = block["name"]!
                        let smallImageUrl = block["url_tn"]!
                        let bigImageUrl = block["url"]!
                        imageInfos.append(XTImageInfo(name: name, smallImageUrl: smallImageUrl, bigImageUrl: bigImageUrl))
                    }
                }
            } catch {
                print("Error serializing JSON: \(error)")
            }
        }
    }
}
