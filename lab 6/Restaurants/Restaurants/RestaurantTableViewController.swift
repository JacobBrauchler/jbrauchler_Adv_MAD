//
//  RestaurantTableViewController.swift
//  Restaurants
//
//  Created by Jacob Brauchler on 4/8/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit
import Firebase

class RestaurantTableViewController: UITableViewController {

    var ref: FIRDatabaseReference!
    
    var restaurants = [Restaurant]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        //set up a listener for Firebase data change events
        //        //this event will fire with the initial data and then all data changes
        //        ref.observe(FIRDataEventType.value, with: {snapshot in
        //            self.recipes=[]
        //            //FIRDataSnapshot represents the Firebase data at a given time
        //            //gets all the child data nodes
        //            for recipe in snapshot.children.allObjects as! [FIRDataSnapshot]{
        //                let item = recipe.value as! [String:String]
        //                guard let recipeName = item["name"],
        //                    let recipeURL = item["url"]
        //                    else {
        //                        continue
        //                }
        //                //create new recipe object
        //                let newRecipe = Recipe(newname: recipeName, newurl: recipeURL)
        //                //add recipe to recipes array
        //                self.recipes.append(newRecipe)
        //            }
        //            self.tableView.reloadData()
        //        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        
        //set up a listener for Firebase data change events
        //this event will fire with the initial data and then all data changes
        ref.observe(FIRDataEventType.value, with: {snapshot in
            self.restaurants=[]
            //FIRDataSnapshot represents the Firebase data at a given time
            //gets all the child data nodes
            for restaurant in snapshot.children.allObjects as! [FIRDataSnapshot]{
                //create new recipe object
                let newRecipe = Restaurant(snapshot: restaurant)
                //add recipe to recipes array
                self.restaurants.append(newRecipe)
            }
            self.tableView.reloadData()
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantcell", for: indexPath)
        let restaurant = restaurants[indexPath.row]
        cell.textLabel!.text = restaurant.name
        cell.detailTextLabel!.text = restaurant.type
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
            let restaurant = restaurants[indexPath.row]
            //create a child reference in Firebase where the key value is the recipe name
            let restaurantref = ref.child(restaurant.name)
            // Delete the row from Firebase
            restaurantref.ref.removeValue()
        }
        
        //        else if editingStyle == .insert {
        //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        if segue.identifier == "savesegue" {
            let source = segue.source as! AddViewController
            if source.addedrestaurant.isEmpty == false {
                //create new recipe object
                let newRecipe = Restaurant(newname: source.addedrestaurant, newurl: source.addedurl, newtype: source.addedtype)
                //add recipe to recipes array
                restaurants.append(newRecipe)
                //create Dictionary
                let newRecipeDict = ["name": source.addedrestaurant, "url": source.addedurl, "type": source.addedtype]
                //create a child reference in Firebase where the key value is the recipe name
                let reciperef = ref.child(source.addedrestaurant)
                //write data to Firebase
                reciperef.setValue(newRecipeDict)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showdetail" {
            let detailVC = segue.destination as! WebViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            let restaurant = restaurants[indexPath.row]
            //sets the data for the destination controller
            detailVC.title = restaurant.name
            detailVC.webpage = restaurant.url
        }
    }
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
