//
//  StartViewController.swift
//  Speed Investor
//
//  Created by Edgar Palic on 3/19/19.
//  Copyright © 2019 Edgar Palic. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class StartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellIdentity = "cellIdentity"
    var entries = [Users]()
    var locationManager:CLLocationManager = CLLocationManager()

    @IBOutlet weak var highScoreTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        highScoreTableView.dataSource = self
        highScoreTableView.delegate = self
        getScoreboardData()
       
    }
    
    // Collect data from firebase.
    func getScoreboardData() {
        
        Database.database().reference().child("scoreboard").observe(.childAdded) { (snapshot) in
            
            let snapvalue = snapshot.value as! [String: String]
            if let name = snapvalue["Username"], let stringscore = snapvalue["Score"], let score = Int(stringscore) {
            let newUser = Users()
                newUser.username = name
                newUser.score = score
            
                self.entries.append(newUser)
                self.highScoreTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    // The leaderboard where we format the generic cells to display number, username and score. List is also sorted based on score.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath) as! TableViewCell
        let cellRank = indexPath.row + 1
        
        cell.lblCellUsername.text = "\(cellRank). " + entries[indexPath.row].username
        cell.lblCellScore.text = "\(entries[indexPath.row].score)"
        entries.sort(by: {$0.score > $1.score})
        
        return cell
    }
}
