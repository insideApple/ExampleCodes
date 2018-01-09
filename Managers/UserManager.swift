//
//  UserManager.swift
//  ItemBI
//
//  Created by Vivek on 04/12/17.
//  Copyright © 2017 Vivek. All rights reserved.
//

import UIKit

private let kSearchHistory = "SearchHistory"
private let kLanguageVersion = "LanguageVersion"
private let kUserName = "UserName"
private let kCompanyName = "CompanyName"
private let kUserPhone = "UserPhoneNumber"
private let kUserEmail = "UserEmail"
private let kAboutMe = "AboutMe"


class UserManager {

    static var searchHistory: NSMutableArray?{
        get{
            
            let tempArray: NSMutableArray = UserDefaults.standard.mutableArrayValue(forKey: kSearchHistory)
            
            print("search History \(tempArray.count > 0 ? tempArray : [])")
//            return UserDefaults.standard.mutableArrayValue(forKey: kSearchHistory)
            return tempArray.count > 0 ? tempArray : []

        }
        set{
            UserDefaults.standard.set(newValue, forKey: kSearchHistory)
            UserDefaults.standard.synchronize()
        }
    }
    

    static var DeviceUDID : String?{
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    
    
    
    static var LanguageVersion : Int?{
        
        set{
            UserDefaults.standard.set(newValue, forKey: kLanguageVersion)
            UserDefaults.standard.synchronize()
        }
        get{
            let language = UserDefaults.standard.integer(forKey: kLanguageVersion)
            return language
        }
    }
    
    static var userName : String?{
        
        set{
            UserDefaults.standard.set(newValue, forKey: kUserName)
            UserDefaults.standard.synchronize()
        }
        get{
            let user = UserDefaults.standard.string(forKey: kUserName) ?? "Iqdesk"
            return user
        }
    }
    
    static var companyName : String?{
        
        set{
            UserDefaults.standard.set(newValue, forKey: kCompanyName)
            UserDefaults.standard.synchronize()
        }
        get{
            let company = UserDefaults.standard.string(forKey: kCompanyName) ?? "Iqdesk Ltd"
            return company
        }
    }
    
    static var userPhone : String?{
        
        set{
            UserDefaults.standard.set(newValue, forKey: kUserPhone)
            UserDefaults.standard.synchronize()
        }
        get{
            let phone = UserDefaults.standard.string(forKey: kUserPhone) ?? ""
            return phone
        }
    }
    
    
    static var userEmail : String?{
        
        set{
            UserDefaults.standard.set(newValue, forKey: kUserEmail)
            UserDefaults.standard.synchronize()
        }
        get{
            let email = UserDefaults.standard.string(forKey: kUserEmail) ?? ""
            return email
        }
    }
    
    static var aboutMe : String?{
        set{
            UserDefaults.standard.set(newValue, forKey: kAboutMe)
            UserDefaults.standard.synchronize()
        }
        get{
            let aboutme = UserDefaults.standard.string(forKey: kAboutMe) ?? ""
            return aboutme
        }
    }
    
}
