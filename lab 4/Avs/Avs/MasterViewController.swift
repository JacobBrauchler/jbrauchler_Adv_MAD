//
//  MasterViewController.swift
//  Avs
//
//  Created by Jacob Brauchler on 3/17/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var players = [[String : String]]()
    
    func getDataFile() -> String? {
        //use a Bundle object of the directory for our application to retrieve the pathname of artistalbums.plist
        guard let pathString = Bundle.main.path(forResource: "avs", ofType: "plist") else {
            return nil
        }
        return pathString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
         self.navigationItem.leftBarButtonItem = self.editButtonItem()
         let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
         self.navigationItem.rightBarButtonItem = addButton
         */
        guard let path = getDataFile() else{
            print("Error loading file")
            return
        }
        
        //load the data of the plist file into the dictionary
        let alldata = NSDictionary(contentsOfFile: path) as! [String: [[String : String]]]
        //print(alldata)
        if alldata.isEmpty != true {
            players = Array(alldata["players"]!)
        }
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
     func insertNewObject(sender: AnyObject) {
     objects.insert(NSDate(), atIndex: 0)
     let indexPath = NSIndexPath(forRow: 0, inSection: 0)
     self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
     }
     */
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let character = players[indexPath.row]
                let url = character["url"]! as String
                let name = character["name"]! as String
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = url as AnyObject?
                controller.title = name
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! tableCell
        let player = players[indexPath.row]
        cell.nameLabel?.text = player["name"]! as String
        cell.positionLabel?.text = player["position"]! as String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    
    //    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    //        if editingStyle == .Delete {
    //            objects.removeAtIndex(indexPath.row)
    //            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    //        } else if editingStyle == .Insert {
    //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    //        }
    //    }
    
    
}

