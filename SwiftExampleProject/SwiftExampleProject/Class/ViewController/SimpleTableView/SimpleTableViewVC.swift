//
//  SimpleTableViewVC.swift
//  SwiftExampleProject
//
//  Created by Vivek on 17/11/17.
//  Copyright © 2017 Vivek. All rights reserved.
//

import UIKit

class SimpleTableViewVC: BaseVC,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var cellArray : NSMutableArray!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cellArray = NSMutableArray.init(array: ["1","2","3","4","5"])

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = UIView()
        addPlusButton()
        
        self.showAlert(title: "", msg: "You can delete cell by right swipe")

    }
    
    func addPlusButton() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        
        navigationItem.rightBarButtonItem = add
    }
    
    @objc func addPressed() {
        
        let randomNumber = Int(arc4random_uniform(1000))

        cellArray.insert("\(randomNumber + 1)", at: cellArray.count)
        self.tableView.reloadData()
        
//        tableView.beginUpdates()
//        cellArray.insert("\(cellArray.count+1)", at: cellArray.count)
//        tableView.insertRows(at: [IndexPath(row: cellArray.count-1, section: 0)], with: .automatic)
//        tableView.endUpdates()
    }
    
   
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell")!

//        let cellNumber = String(indexPath.row+1)
        
        let lblName : UILabel! = cell.viewWithTag(101) as! UILabel
//        lblName.text  = "Cell : \(cellArray.object(at: indexPath.row))"
        lblName.text  = "Cell : \(indexPath.row)"

        cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.white : UIColor.init(red: 191.0/256.0, green: 232.0/256.0, blue: 242.0/256.0, alpha: 1)

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            cellArray.remove(cellArray.object(at: indexPath.row))
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
