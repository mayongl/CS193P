//
//  DemoURL.swift
//  Cassini
//
//  Created by Yonglin Ma on 3/27/17.
//  Copyright © 2017 Sixlivesleft. All rights reserved.
//

import Foundation

struct DemoURL
{
    static let Standford = URL(string: "http://comm.stanford.edu/mm/2016/08/mcclatchy-hall-600x300.jpg")
    
   static var NASA : Dictionary<String,URL> = {
        let NASAURLStrings = [
            "Cassini" : "http://mimg.xmeise.com/thumb/m/mmimg/39/39990/39990_44.jpg",
            "Earth" : "http://img.daimg.com/uploads/allimg/161019/3-161019225355.jpg",
            "Saturn" : "http://mimg.xmeise.com/thumb/m/mmimg/39/39973/39973_13.jpg"]
        
        var urls = Dictionary<String, URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
 
