//
//  MasterViewController.swift
//  NHLStandings
//
//  Created by Jacob Brauchler on 4/4/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var objects = [[String:String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadjson()
    }
    
    func loadjson(){
        let urlPath = "https://statsapi.web.nhl.com/api/v1/standings?season=20152016"
        guard let url = URL(string: urlPath)
            else {
                print("url error")
                return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                fatalError("Error is \(error)")
            }
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any] {
                        if let records = json["records"] as? [[String:Any]] {
                            for record in records {
                                let division = record["division"] as? [String:Any]
                                //print("The divisionName is \(divisionName) and its ID is \(divisionID)")
                                if let teamRecords = record["teamRecords"] as? [[String:Any]] {
                                    
                                    for teamRecord in teamRecords {
                                        let team = teamRecord["team"] as? [String:Any]
                                        let teamName = team?["name"] as? String
                                        let leagueRecord = teamRecord["leagueRecord"]! as? [String:Any]
                                        let losses = leagueRecord?["losses"]! as? Int
                                        let overtime = leagueRecord?["ot"]! as? Int
                                        let wins = leagueRecord?["wins"]! as? Int
                                        let points = (wins! * 2) + overtime!
                                        //print(points)
                                        
                                    let obj = ["team": teamName!, "wins": String(wins!), "loses": String(losses!), "overtimeLoses": String(overtime!), "points": String(points)] as [String : Any]
                                      
                                        //print (obj)
                                    self.objects.append(obj as! [String : String])
                                    DispatchQueue.main.async {self.tableView.reloadData()}
                                        
                                    }
                                }
                                
                            }
                        }
                    }
                } catch {
                    fatalError("Error parsing data \(error)")
                }
            }
            
        }.resume()
        

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let teams = objects[indexPath.row]
                let team = teams["team"]
                let points = teams["points"]
                let wins = teams["wins"]
                let loses = teams["loses"]
                let overtimeLoses = teams["overtimeLoses"]
                let controller = (segue.destination as! DetailViewController)
                controller.points = points!
                controller.team = team!
                controller.loses = loses!
                controller.overtimeLoses = overtimeLoses!
                controller.wins = wins!
                //controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let teams = objects[indexPath.row]
        print(teams)
        cell.textLabel!.text = teams["team"]
        if teams["points"] != nil {
            cell.detailTextLabel!.text = teams["points"]! + " points"
        }
        return cell
    }
    
}

