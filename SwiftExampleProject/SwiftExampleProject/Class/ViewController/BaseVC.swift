//
//  BaseVC.swift
//  SwiftExampleProject
//
//  Created by Vivek on 17/11/17.
//  Copyright © 2017 Vivek. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func showAlert(title:String , msg : String) {
        let alertView = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }

   

}
