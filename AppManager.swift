//
//  AppManager.swift
//  VideoDL
//
//  Created by Vivek Padaya on 11/01/18.
//  Copyright © 2018 Vivek. All rights reserved.
//

import UIKit

private var kVideoList = "VideoList"

class AppManager: NSObject {
    
   static var videoList : [VideoModel]{
        set{
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(encodedData, forKey: kVideoList)
            userDefaults.synchronize()
        }
        get{
            let userDefaults = UserDefaults.standard
            if let decoded  = userDefaults.object(forKey: kVideoList) as? Data {
                let decodedList = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [VideoModel]
                return decodedList!
            }
           return [VideoModel]()
        }
    }

}
