//
//  VideoModel.swift
//  VideoDL
//
//  Created by Vivek Padaya on 11/01/18.
//  Copyright © 2018 Vivek. All rights reserved.
//

import UIKit

class VideoModel: NSObject,NSCoding {

    var fileName : String!
    var filePath : String!
    
    init(file_name: String, file_path: String) {
        self.fileName = file_name
        self.filePath = file_path
        
    }
    override init() {
        print("Init video model")
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let file_name = aDecoder.decodeObject(forKey: "name") as! String
        let file_path = aDecoder.decodeObject(forKey: "path") as! String
        self.init(file_name: file_name, file_path: file_path)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(fileName, forKey: "name")
        aCoder.encode(filePath, forKey: "path")

    }
}
