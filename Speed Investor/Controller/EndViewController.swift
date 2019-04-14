//
//  EndViewController.swift
//  Speed Investor
//
//  Created by user151107 on 3/12/19.
//  Copyright © 2019 user151107. All rights reserved.
//

import UIKit
import Firebase

class EndViewController: UIViewController {
    
    @IBOutlet weak var lblFinalScore: UILabel!
    @IBOutlet weak var lblFinalWords: UILabel!
    @IBOutlet weak var txtInsertName: UITextField!
    @IBOutlet weak var btnUploadScore: UIButton!
    @IBOutlet weak var btnBackToStart: UIButton!
    
    var username = Users().username
    var score = Users().score
    var scoreArray : [Users] = [Users]()
    
    var currentScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblFinalWords.text = "Write your name bellow to upload your score!"
        lblFinalScore.text = "\(currentScore)"
    }
    
    // This button sends the input username and the final score to firebase.
    @IBAction func btnUploadScore(_ sender: UIButton) {
        
        score = currentScore
        username = txtInsertName.text!
        
        let user = ["Username":username, "Score":"\(score)"]
        
        let scoresDB = Database.database().reference().child("scoreboard")
        
        scoresDB.childByAutoId().setValue(user){
            
            (error, reference) in
            if error != nil {
                print(error!)
            } else {
                print("Score saved successfully!")
            }
        }
    }
    
    @IBAction func btnBackToStart(_ sender: UIButton) {
    }
    
}
