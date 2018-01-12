//
//  LoginVC.swift
//  SwiftExampleProject
//
//  Created by Vivek on 17/11/17.
//  Copyright © 2017 Vivek. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {

    @IBOutlet var txtUName: UITextField!
    @IBOutlet var txtPwd: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Login"
    }

    @IBAction func actnLogin(_ sender: Any) {
        
        if (!self.txtUName.hasText && !self.txtPwd.hasText){
            self.showAlert(title: "Input required", msg: "Username and Password  required")
            return
        }
        
        let uName = self.txtUName.text
        let pwd  = self.txtPwd.text
        
        
        
        var userList : NSMutableArray = NSMutableArray()
        
        if DataManager.userArray.count > 0{
            userList = DataManager.userArray!.mutableCopy() as! NSMutableArray
        }else{
            userList = NSMutableArray()
        }
        
        var isMatchFound : Bool = false
        var userId: String = ""
        var userName: String = ""

        
        for user in userList {
            let dictUser = user as! NSDictionary
            let tempUname = dictUser["userName"] as! String
            let tempPwd = dictUser["password"] as! String

            
            if (uName == tempUname){
                if (pwd == tempPwd){
                    isMatchFound = true;
                    userId = dictUser["userId"] as! String
                    userName = dictUser["userName"]! as! String
                }
            }
        }
        
        if isMatchFound{
            let alertView = UIAlertController(title: "Login Success", message: "User Id : \(userId)", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (result : UIAlertAction) in
                self.navigationController?.popViewController(animated: true)

            }))
//            alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (result : UIAlertAction) -> Void in
//                self.navigationController?.popViewController(animated: true)
//            }
            self.present(alertView, animated: true, completion: nil)
            
            UserDefaults.standard.set(userName, forKey: Constants.kUsersName)
            UserDefaults.standard.set(true, forKey: Constants.kIsLogin)
        }else{
            self.showAlert(title: "Wrong Login", msg: "User Name or Password dosen't match")
        }

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
