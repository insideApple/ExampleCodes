//
//  CalVC.swift
//  SwiftExampleProject
//
//  Created by Vivek on 16/11/17.
//  Copyright © 2017 Vivek. All rights reserved.
//

import UIKit

class CalVC: BaseVC {

    @IBOutlet var txtOne: UITextField!
    @IBOutlet var txtTwo: UITextField!
    @IBOutlet var lblResult: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Calculator"
    }

    @IBAction func actnClear(_ sender: Any) {
        ClearAll()
    }
    
    @IBAction func actnMinus(_ sender: Any) {
        minusTextField()
    }
    
    @IBAction func actnPlus(_ sender: Any) {
        plusTextField()
        
    }
    
    func ClearAll() {
        txtOne.text = ""
        txtTwo.text = ""
        lblResult.text = "Result"
        
    }
    
    func plusTextField()  {
        
        if (txtTwo.hasText || txtOne.hasText){
        
            let textfieldInt: Double? = Double(txtOne.text!)
            let textfield2Int: Double? = Double(txtTwo.text!)
            let convert = textfieldInt! + textfield2Int!
            let convertText = String(convert)
            lblResult.text = "Result : \(convertText)"
        }else{
            
            let alertView = UIAlertController(title: "Field required", message: "Both field is required", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
            
        }
        
        
    }
    
    func minusTextField()  {
        if (txtTwo.hasText || txtOne.hasText){
            let textfieldInt: Double? = Double(txtOne.text!)
            let textfield2Int: Double? = Double(txtTwo.text!)
            let convert = textfieldInt! - textfield2Int!
            let convertText = String(convert)
            lblResult.text = "Result : \(convertText)"
        }else{
            let alertView = UIAlertController(title: "Field required", message: "Both field is required", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        }
      
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
