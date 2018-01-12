//
//  FirstVC.swift
//  SwiftExampleProject
//
//  Created by Vivek on 16/11/17.
//  Copyright © 2017 Vivek. All rights reserved.
//

import UIKit

class FirstVC: BaseVC {
    
    var vcName: String?
    
    @IBOutlet var lblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblName.text = vcName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
