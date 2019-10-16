//
//  SettingsTableViewController.swift
//  YobitParser
//
//  Created by Дмитрий Ю on 03.01.2018.
//  Copyright © 2018 Дмитрий Ю. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
var defaultTikerName : [String] = []
var customTikerName : [String] = ["btc_usd", "zec_usd", "eth_usd", "b2x_usd"]
@IBOutlet weak var fieldForTicker: UITextField!   //поле для ввода символа
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.value(forKey: "savedTikerName") != nil {
        defaultTikerName = (UserDefaults.standard.value(forKey: "savedTikerName") as! [String])
        } else {
            defaultTikerName = customTikerName
        }
        print(defaultTikerName)
        print(customTikerName)
        
        //tableView.backgroundColor = UIColor.darkGray
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func addTicker(_ sender: UIBarButtonItem) {
        defaultTikerName.append(fieldForTicker.text!)
        let indexPath = IndexPath(row: defaultTikerName.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        UserDefaults.standard.set(defaultTikerName, forKey: "savedTikerName")
        fieldForTicker.text = ""
        view.endEditing(true)
    }
    
    // Вернуться назад
    @IBAction func backToTVC(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "id1")
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return defaultTikerName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = defaultTikerName[indexPath.row]
        //print(customTikerName)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            defaultTikerName.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(defaultTikerName, forKey: "savedTikerName")
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}
