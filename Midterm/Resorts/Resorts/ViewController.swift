//
//  ViewController.swift
//  Resorts
//
//  Created by Jacob Brauchler on 3/16/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var resortList = Resorts()
    let kfilename = "data.plist"
    
    func getDataFile() -> String? {
        //use a Bundle object of the directory for our application to retrieve the pathname of continents.plist
        guard let pathString = Bundle.main.path(forResource: "resorts", ofType: "plist") else {
            return nil
        }
        return pathString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path:String?
        let filePath = docFilePath(kfilename) //path to data file
        //print(filePath)
        
        //if the data file exists, use it
        if FileManager.default.fileExists(atPath: filePath!){
            path = filePath
            //print(path)
        }
        else {
            path = getDataFile()
        }
        
        //load the data of the plist file into the dictionary
        resortList.resortData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        //puts all the continents in an array
        resortList.resorts = Array(resortList.resortData.keys)
        
        //application instance
        let app = UIApplication.shared
        //subscribe to the UIApplicationWillResignActiveNotification notification
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
    }
    
    @IBAction func preparetounwind(_ segue: UIStoryboardSegue){
        print("unwinding")
    }
    
    //Required methods for UITableViewDataSource
    //Number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resortList.resortData.count
    }
    
    // Displays table view cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = resortList.resorts[indexPath.row]
        return cell
    }
    
    //Handles segues to other view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "runSegue" {
            let detailVC = segue.destination as! DetailViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            //sets the data for the destination controller
            detailVC.title = resortList.resorts[indexPath.row]
            detailVC.resortListDetail=resortList
            detailVC.selectedResort = indexPath.row
        } //for detail disclosure
        else if segue.identifier == "siteSegue"{
            let infoVC = segue.destination as! ResortWebsiteViewController
            let editingCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: editingCell)
            infoVC.name = resortList.resorts[indexPath!.row]
        }
    }
    
    func docFilePath(_ filename: String) -> String?{
        //locate the documents directory
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = path[0] as NSString //document directory
        //print(dir)
        //creates the full path to our data file
        return dir.appendingPathComponent(filename)
    }
    
    //called when the UIApplicationWillResignActiveNotification notification is posted
    //all notification methods take a single NSNotification instance as their argument
    func applicationWillResignActive(_ notification: Notification){
        let filePath = docFilePath(kfilename)
        let data = NSMutableDictionary()
        //adds our whole dictionary to the data dictionary
        data.addEntries(from: resortList.resortData)
        //print(data)
        //write the contents of the array to our plist file
        data.write(toFile: filePath!, atomically: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

