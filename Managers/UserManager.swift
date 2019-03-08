//
//  UserManager.swift
//  ItemBI
//
//  Created by Vivek on 04/12/17.
//  Copyright © 2017 Vivek. All rights reserved.
//

import UIKit
private let kUserModel = "UserModel"

private let kSearchHistory = "SearchHistory"
private let kLanguageVersion = "LanguageVersion"
private let kUserName = "UserName"
private let kFName = "FirstName"
private let kLName = "LastName"

private let kCompanyName = "CompanyName"
private let kUserPhone = "UserPhoneNumber"
private let kUserEmail = "UserEmail"
private let kAboutMe = "AboutMe"
private let kAboutUsUrl = "AboutUsURL"
private let kAboutUsText = "AboutUsText"

private let kIsGoToHome = "isGoToHome"
private let kIsExpert = "isExpert"
private let kIsPushUpdated = "isPushUpdated"

private let kIsRegister = "IsRegister"
private let kDeviceToken = "DeviceToken"
private let kCountryCode = "CountryCode"

private let kGroupId = "GroupID"
private let kToken = "Token"
private let kDeviceUDID = "DeviceUDID"
private let kDistance = "Distance"

private let kIsVehicleOwner = "IsVehicleOwner"
private let kIsLoadOwner = "IsLoadOwner"


class UserManager {

    static var loginUser : UserModel!{
        set{
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey:kUserModel)
            }else{
                UserDefaults.standard.set(try! PropertyListEncoder().encode(newValue), forKey: kUserModel)
                UserDefaults.standard.synchronize()
            }
        }
        get{
            if let storedObject: Data = UserDefaults.standard.object(forKey: kUserModel) as? Data {
                do{
                    let storedUser: UserModel? = try PropertyListDecoder().decode(UserModel.self, from: storedObject)
                    if storedUser == nil {
                        return UserModel()
                    }else{
                        return storedUser
                    }
                }catch{
                    return nil
                }
                
            }
            return nil
        }
    }
    
    
    static var isVehicleOwner : Bool{
        get {
            let vehicleOwner = UserDefaults.standard.bool(forKey: kIsVehicleOwner)
            return vehicleOwner
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kIsVehicleOwner)
            UserDefaults.standard.synchronize()
        }        
    }
    static var isLoadOwner : Bool{
        get {
            let isLoadOwner = UserDefaults.standard.bool(forKey: kIsLoadOwner)
            return isLoadOwner
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kIsLoadOwner)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var distance : Int?{
        get{
            let distance_temp = UserDefaults.standard.integer(forKey: kDistance)
            if distance_temp == 0 {
                return 1000
            }
            return distance_temp
        }
        set{
            UserDefaults.standard.set(newValue, forKey: kDistance)
            UserDefaults.standard.synchronize()
        }
    }
    

    static var DeviceUDID : String?{
        get{
            let udid = UserDefaults.standard.string(forKey: kDeviceUDID) ?? ""
            return udid
        }
        set{
            UserDefaults.standard.set(newValue, forKey: kDeviceUDID)
            UserDefaults.standard.synchronize()
        }
        //        return UIDevice.current.identifierForVendor!.uuidString
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
    
    static var fName : String?{
        
        set{
            UserDefaults.standard.set(newValue, forKey: kFName)
            UserDefaults.standard.synchronize()
        }
        get{
            let user = UserDefaults.standard.string(forKey: kFName) ?? ""
            return user
        }
    }
    
    static var lName : String?{
        
        set{
            UserDefaults.standard.set(newValue, forKey: kLName)
            UserDefaults.standard.synchronize()
        }
        get{
            let user = UserDefaults.standard.string(forKey: kLName) ?? ""
            return user
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
    
   
    static var isGoToHome : Bool!{
        set{
            UserDefaults.standard.set(newValue, forKey: kIsGoToHome)
            UserDefaults.standard.synchronize()
        }
        get{
            let isHome = UserDefaults.standard.bool(forKey: kIsGoToHome)
            return isHome
        }
    }
    
    
    
    static var isRegister : Bool!{
        set{
            UserDefaults.standard.set(newValue, forKey: kIsRegister)
            UserDefaults.standard.synchronize()
        }
        get{
            let is_register = UserDefaults.standard.bool(forKey: kIsRegister)
            return is_register
        }
    }
    
   
    static var deviceToken : String?{
        set{
            UserDefaults.standard.set(newValue, forKey: kDeviceToken)
            UserDefaults.standard.synchronize()
        }
        get{
            let deviceToken = UserDefaults.standard.string(forKey: kDeviceToken) ?? "#simulator"
            return deviceToken
        }
    }
    
    static var countryCode : String?{
        set{
            UserDefaults.standard.set(newValue, forKey: kCountryCode)
            UserDefaults.standard.synchronize()
        }
        get{
            let countycode = UserDefaults.standard.string(forKey: kCountryCode) ?? ""
            return countycode
        }
    }
    
    
    static var token : String?{
        set{
            UserDefaults.standard.set(newValue, forKey: kToken)
            UserDefaults.standard.synchronize()
        }
        get{
            let groupid = UserDefaults.standard.string(forKey: kToken) ?? ""
            return groupid
        }
    }
   
}
