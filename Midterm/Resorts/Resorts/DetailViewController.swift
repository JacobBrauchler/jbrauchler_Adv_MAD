//
//  DetailViewController.swift
//  Resorts
//
//  Created by Jacob Brauchler on 3/16/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    var runs = [String]()
    var selectedResort = 0
    var resortListDetail = Resorts()
    var searchController : UISearchController!
    
    override func viewWillAppear(_ animated: Bool) {
        resortListDetail.resorts = Array(resortListDetail.resortData.keys)
        let chosenResort = resortListDetail.resorts[selectedResort]
        runs = resortListDetail.resortData[chosenResort]! as [String]
        let resultsController = SearchResultsViewController() //create an instance of our SearchResultsController class
        resultsController.allRuns = runs //set the allwords property to our words array
        searchController = UISearchController(searchResultsController: resultsController) //initialize our search controller with the resultsController when it has search results to display
        
        //search bar configuration
        searchController.searchBar.placeholder = "Enter a search term" //place holder text
        searchController.searchBar.sizeToFit() //sets appropriate size for the search bar
        tableView.tableHeaderView=searchController.searchBar //install the search bar as the table header
        searchController.searchResultsUpdater = resultsController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("view will disappear")
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
        return runs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = runs[indexPath.row]
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the country from the array
            runs.remove(at: indexPath.row)
            let chosenResort = resortListDetail.resorts[selectedResort]
            //Delete from the data model
            resortListDetail.resortData[chosenResort]?.remove(at: indexPath.row)
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let fromRow = fromIndexPath.row //row being moved from
        let toRow = toIndexPath.row //row being moved to
        let moveCountry = runs[fromRow] //country being moved
        //move in array
        runs.remove(at: fromRow)
        runs.insert(moveCountry, at: toRow)
        //move in data model
        let chosenResort = resortListDetail.resorts[selectedResort]
        resortListDetail.resortData[chosenResort]?.remove(at: fromRow)
        resortListDetail.resortData[chosenResort]?.insert(moveCountry, at: toRow)
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            let source = segue.source as! AddRunViewController
            //only add a country if there is text in the textfield
            if ((source.addedRun.isEmpty) == false){
                runs.append(source.addedRun)
                tableView.reloadData()
                let chosenResort = resortListDetail.resorts[selectedResort]
                resortListDetail.resortData[chosenResort]?.append(source.addedRun)
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
