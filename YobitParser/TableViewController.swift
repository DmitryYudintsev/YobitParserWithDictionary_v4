//
//  TableViewController.swift
//  YobitParser
//
//  Created by Дмитрий Ю on 23.12.2017.
//  Copyright © 2017 Дмитрий Ю. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
    
    var structure = StructDictToYobit()
    var customTikerName : [String] = ["btc_usd", "zec_usd", "eth_usd", "b2x_usd"]
    var tikerName : [String] = []
    var filteredTiker = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var dataImage : UIImageView!
    
//=========================================================================================================
    override func viewDidLoad() {
        if UserDefaults.standard.value(forKey: "savedTikerName") != nil {
            tikerName = (UserDefaults.standard.value(forKey: "savedTikerName") as! [String])
        } else {
            tikerName = customTikerName
        }
        print(tikerName)
    //---------------------------------------------------------------------------------------------------
        navigationItem.title = "YObit"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        //self.tableView.reloadData()
        //tikName.append(tikerName)
        //loadDataPing()
        //loadDataGetInfoData()
        //loadDataGetInfoList()
        let image:NSData = NSData(base64Encoded: "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", options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        dataImage.image = UIImage(data: image as Data)
        
        getInfoDataById(id: 2)
        getAdvTypes() {
        structure in
            let codes = [String](structure.keys)
            print(codes)
            print(structure[codes[0]]!.get_adv_types.count)
            print(structure[codes[0]]!.get_adv_types[0])
            
        }
//        loadDataFromYobit(name : "btc_usd") {
//            structure in
//            print(structure)
//        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//строка поиска===========================================================================
    func updateSearchResults(for searchController: UISearchController) {
        filteredTiker = tikerName.filter({ (tikerName) -> Bool in
        tikerName.description.contains(searchController.searchBar.text!)
        })
        tableView.reloadData()
    }
//========================================================================================
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return filteredTiker.count
        }
        return tikerName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        let name = self.searchController.isActive ? self.filteredTiker[indexPath.row] : self.tikerName[indexPath.row]
        loadDataFromYobit(name : name) {
            structure in
                let tikerCodes = [String](structure.keys) //
                let name = tikerCodes[0] //получаем имя тикера
                let last = Int(structure[tikerCodes[0]]!.last!)
                let low = Int(structure[tikerCodes[0]]!.low!)
                let high = Int(structure[tikerCodes[0]]!.high!)
            
            cell.textLabel?.text = (name + " = " + String(last) + "$")
            cell.detailTextLabel?.text = ((String(low)) + "⬇︎ " + (String(high)) + "⬆︎")
            }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue2" {
            let dest = segue.destination as? GraphViewController //ссылка на var из GVC
            let cell = self.tableView.indexPathForSelectedRow!
            let myRow = cell.row
            dest?.tikerNameSegue = tikerName[myRow]  //передаем тикер в Graph...
            
        
        }
    }
}
