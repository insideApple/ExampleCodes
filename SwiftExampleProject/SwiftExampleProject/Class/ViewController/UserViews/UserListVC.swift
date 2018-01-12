//
//  UserListVC.swift
//  SwiftExampleProject
//
//  Created by Vivek on 17/11/17.
//  Copyright © 2017 Vivek. All rights reserved.
//

import UIKit

class UserListVC: BaseVC,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    var userArrayList : NSMutableArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if DataManager.userArray.count > 0{
            userArrayList = DataManager.userArray!.mutableCopy() as! NSMutableArray
        }else{
            userArrayList = NSMutableArray()
        }
        
        print("count : \(userArrayList.count)")
        if userArrayList.count > 0 {
            print(userArrayList)
        }
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = UIView()
        
        addPlusButton()
    }
    
    func addPlusButton() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        
        navigationItem.rightBarButtonItem = add
    }
    
    @objc func addPressed() {
        
        showAlertWithUser()
       
    }
    
    func showAlertWithUser() {
        let alertController = UIAlertController(title: "User detail", message: "SecureStyle AlertView.", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (pwdTxt : UITextField) in
            pwdTxt.isSecureTextEntry = false
            pwdTxt.placeholder = "User Name"
        }
        alertController.addTextField { (pwdTxt : UITextField) in
            pwdTxt.isSecureTextEntry = true
            pwdTxt.placeholder = "Password"
        }
        
        
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            print("Cancel")
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
//            print(alertController.textFields?.first?.text)
//            print(alertController.textFields?.last?.text)
            
            let uNameTxt : UITextField = alertController.textFields![0]
            let pwdTxt : UITextField = alertController.textFields![1]
            
            let name = uNameTxt.text
            let pwd = pwdTxt.text
         
            let randomNumber = Int(arc4random_uniform(1000))
            
            let dict = ["userId" : "\(randomNumber)", "userName" : name , "password" : pwd]
            
            self.userArrayList.add(dict)
            
//            DataManager.sharedManager.addUser(uName: name!, pwd: pwd!)
            UserDefaults.standard.set(self.userArrayList, forKey: Constants.kUsers)

            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: self.userArrayList.count-1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if userArrayList.count == 0{
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//            var emptyLabel = UILabel(frame: CGRect(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            emptyLabel.text = "Tap + to add user"
            emptyLabel.textAlignment = NSTextAlignment.center
            self.tableView.backgroundView = emptyLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            return 0

        }
        self.tableView.backgroundView = UIView()
        return userArrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell")!
        
        //        let cellNumber = String(indexPath.row+1)
        
        let lblName : UILabel! = cell.viewWithTag(101) as! UILabel
        let dictUser : NSDictionary = userArrayList.object(at: indexPath.row) as! NSDictionary
        
        lblName.text  = dictUser.value(forKey: "userName") as? String
        
        cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.white : UIColor.init(red: 191.0/256.0, green: 232.0/256.0, blue: 242.0/256.0, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            let dictUser : NSDictionary = userArrayList.object(at: indexPath.row) as! NSDictionary
            userArrayList.remove(userArrayList.object(at: indexPath.row))
            UserDefaults.standard.set(self.userArrayList, forKey: Constants.kUsers)

            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
