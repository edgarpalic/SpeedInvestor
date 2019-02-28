//
//  ViewController.swift
//  Speed Investor
//
//  Created by user151107 on 2/25/19.
//  Copyright © 2019 user151107. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //////////////////////////LABELS/////////////////////////////
    @IBOutlet weak var lblTotalMoney: UILabel!
    @IBOutlet weak var lblSystemText: UILabel!
    @IBOutlet weak var lblInvestHouseAmount: UILabel!
    @IBOutlet weak var lblInvestHouseCost: UILabel!
    @IBOutlet weak var lblInvestTrainAmount: UILabel!
    @IBOutlet weak var lblInvestTrainCost: UILabel!
    
    
    //////////////////////////BUTTONS/////////////////////////////
    
    @IBOutlet weak var btnClickArea: UIButton!
    @IBOutlet weak var btnBuyHouse: UIButton!
    @IBOutlet weak var btnBuyTrain: UIButton!
    
    
    
    var totalMoney = 0
    var clickMoney = 1
    
    var investHouseCost = 10
    var investHouseAmount = 0
    var investTrainCost = 1000
    var investTrainAmount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        uiMoneyDisplay()
    }
    
    // This is the money earning click area.
    @IBAction func btnClickArea(_ sender: UIButton) {
        totalMoney += clickMoney
        uiMoneyDisplay()
    }
    
    @IBAction func btnBuyHouse(_ sender: UIButton) {
        if totalMoney >= investHouseCost {
            
            totalMoney -= investHouseCost
            investHouseAmount += 1
            investHouseCost *= 2
            clickMoney += investHouseAmount
            
            lblSystemText.text = "House purchased!"
            
            uiMoneyDisplay()
        }
        else{
            lblSystemText.text = "Not enough money!"
        }
    }
    
    @IBAction func btnBuyTrain(_ sender: UIButton) {
        if totalMoney >= investTrainCost {
            totalMoney -= investTrainCost
            investTrainAmount += 10
            investTrainCost *= 2
            clickMoney += investTrainAmount
            
            lblSystemText.text = "Train purchased!"
            uiMoneyDisplay()
        }
        else {
            lblSystemText.text = "Not enough money!"
        }
    }
    
    // This will actively display information regarding investments on the investment buttons. Called in multiple places.
    func uiMoneyDisplay(){
        lblTotalMoney.text = "Cash: $\(totalMoney)"
        lblInvestHouseCost.text = "Cost: $\(investHouseCost)"
        lblInvestTrainCost.text = "Cost: $\(investTrainCost)"
        btnClickArea.setTitle("Income $\(clickMoney)", for: .normal)
        
        if investHouseAmount >= 1 {
        lblInvestHouseAmount.text = "Income: $\(investHouseAmount)"
        }
        else{
            lblInvestHouseAmount.text = "Income: $0"
        }
        if investTrainAmount >= 1 {
            lblInvestTrainAmount.text = "Income: $\(investTrainAmount)"
        }
        else{
            lblInvestTrainAmount.text = "Income: $0"
        }
        
    }


}

