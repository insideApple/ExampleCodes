//
//  DataManager.swift
//  SwiftExampleProject
//
//  Created by Vivek on 16/11/17.
//  Copyright © 2017 Vivek. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    static let sharedManager = DataManager()
    
    static var mainPageTitle = ["Users List", "Calculator", "TableView", "TabBar" ,"Empty page One", "Empty page Two",]
    
    static var userArray : NSMutableArray! = UserDefaults.standard.mutableArrayValue(forKey: Constants.kUsers)
    
    static var userLoginName : String! = UserDefaults.standard.string(forKey: Constants.kUsersName)
    
    static var isLogin : Bool = UserDefaults.standard.bool(forKey: Constants.kIsLogin)

    
    public func addUser(uName:String , pwd: String) {
        let dict = ["userName" : uName , "password" : pwd]

        let userArrayList : NSMutableArray! = UserDefaults.standard.mutableArrayValue(forKey: Constants.kUsers)
        userArrayList.add(dict)
        
        UserDefaults.standard.set(userArrayList, forKey: Constants.kUsers)
    }
    
    public func removeUser(dictUser : NSDictionary){
        
        let userArrayList : NSMutableArray! = UserDefaults.standard.mutableArrayValue(forKey: Constants.kUsers)
        userArrayList.remove(dictUser)
        
        UserDefaults.standard.set(userArrayList, forKey: Constants.kUsers)
    }
}
