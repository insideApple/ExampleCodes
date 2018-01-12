//
//  TableViewVC.swift
//  SwiftExampleProject
//
//  Created by Vivek on 16/11/17.
//  Copyright © 2017 Vivek. All rights reserved.
//

import UIKit
enum CellItem : Int {
    case CellItemUsers = 0 ,
    CellItemCal,
    CellItemTableView,
    CellItemTabBar,
    CellItemFirst,
    CellItemSecond,
    CellItemLogin
}
class TableViewVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var lblInfo: UILabel!
    var loginBarButton : UIBarButtonItem!
    var logoutBarButton : UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLogin()

        self.tableView.reloadData()
    }
    
    func checkLogin() {
      
        
        let isLogin : Bool = UserDefaults.standard.bool(forKey: Constants.kIsLogin)
        
        if isLogin{
            let userName : String! = UserDefaults.standard.object(forKey: Constants.kUsersName) as! String
            
            
            if (userName != nil) {
                if userName.characters.count > 0 {
                    self.title = "Welcome \(userName!)"
                    self.lblInfo.text = "You are login with Username : \(userName!)"
                    self.lblInfo.textColor = UIColor.lightGray
                    addLogout()
                }
            }
        }else{
            self.title = "Demo Swift"
            self.lblInfo.text = "Login to enable Other feature.\n You can register user in Users List"
            self.lblInfo.textColor = UIColor.red
            addLoginButton()
        }

       
        
        
    }
    
    func addLogout() {
        self.logoutBarButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logoutPressed))
        
        navigationItem.rightBarButtonItem = logoutBarButton
    }
    
    func addLoginButton() {
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(loginPressed))
        self.loginBarButton = UIBarButtonItem(title: "Login", style: UIBarButtonItemStyle.plain, target: self, action: #selector(loginPressed))
        
        navigationItem.rightBarButtonItem = loginBarButton
    }
    
    @objc func loginPressed() {
        let login:LoginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(login, animated: true)
    }
    
    @objc func logoutPressed() {
        self.title = "Demo Swift"
        UserDefaults.standard.set("", forKey: Constants.kUsersName)
        UserDefaults.standard.set(false, forKey: Constants.kIsLogin)
        checkLogin()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let isLogin : Bool = UserDefaults.standard.bool(forKey: Constants.kIsLogin)
        
        if !isLogin{
            return 1
        }
        return DataManager.mainPageTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Create cell with identifier
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell")!
        
        // Get custom label
        let lblName : UILabel! = cell.viewWithTag(101) as! UILabel
        lblName.text  = DataManager.mainPageTitle[indexPath.row]
        
        // Change background color of cell
        cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.white : UIColor.init(red: 213.0/256.0, green: 245.0/256.0, blue: 227.0/256.0, alpha: 1)
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellItem = CellItem(rawValue: indexPath.row)// indexPath.row
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch cellItem! {
        case .CellItemFirst:
            let firstVc:FirstVC = self.storyboard?.instantiateViewController(withIdentifier: "FirstVC") as! FirstVC
            firstVc.vcName = DataManager.mainPageTitle[indexPath.row]
            self.navigationController?.pushViewController(firstVc, animated: true)
            
        case .CellItemSecond:
            let seconVc:FirstVC = self.storyboard?.instantiateViewController(withIdentifier: "FirstVC") as! FirstVC
            seconVc.vcName = DataManager.mainPageTitle[indexPath.row]
            self.navigationController?.pushViewController(seconVc, animated: true)
            
        case .CellItemCal:
            let calVc:CalVC = self.storyboard?.instantiateViewController(withIdentifier: "CalVC") as! CalVC
            self.navigationController?.pushViewController(calVc, animated: true)
            
        case .CellItemTableView:
            let table:SimpleTableViewVC = self.storyboard?.instantiateViewController(withIdentifier: "SimpleTableViewVC") as! SimpleTableViewVC
            self.navigationController?.pushViewController(table, animated: true)
            
        case .CellItemUsers:
            let users:UserListVC = self.storyboard?.instantiateViewController(withIdentifier: "UserListVC") as! UserListVC
            self.navigationController?.pushViewController(users, animated: true)
            
        case .CellItemLogin:
            let login:LoginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(login, animated: true)
            
        case .CellItemTabBar:
            let tabBar: TabBarVc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVc") as! TabBarVc
            self.navigationController?.pushViewController(tabBar, animated: true)
            
        default:
            print("Nothing to do")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
