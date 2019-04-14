//
//  ViewController.swift
//  Speed Investor
//
//  Created by user151107 on 2/25/19.
//  Copyright © 2019 user151107. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    /////////////////////////////LABELS//////////////////////////////
    
    @IBOutlet weak var lblTotalMoney: UILabel!
    @IBOutlet weak var lblSystemText: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblInvestHouseAmount: UILabel!
    @IBOutlet weak var lblInvestHouseCost: UILabel!
    @IBOutlet weak var lblInvestTrainAmount: UILabel!
    @IBOutlet weak var lblInvestTrainCost: UILabel!
    @IBOutlet weak var lblInvestAirplaneAmount: UILabel!
    @IBOutlet weak var lblInvestAirplaneCost: UILabel!
    @IBOutlet weak var lblInvestSkyscraperAmount: UILabel!
    @IBOutlet weak var lblInvestSkyscraperCost: UILabel!
    
    ////////////////////////////BUTTONS//////////////////////////////
    
    @IBOutlet weak var btnClickArea: UIButton!
    @IBOutlet weak var btnBuyHouse: UIButton!
    @IBOutlet weak var btnBuyTrain: UIButton!
    @IBOutlet weak var btnBuyAirplane: UIButton!
    @IBOutlet weak var btnBuySkyscraper: UIButton!
    
     ///////////////////////////VARIABLES////////////////////////////
    
    var totalMoney = 0
    var clickMoney = 1
    var timeCount = 60
    
    var investHouseCost = 10
    var investHouseAmount = 1
    var investTrainCost = 1000
    var investTrainAmount = 0
    var investAirplaneCost = 2000
    var investAirplaneAmount = 0
    var investSkyscraperCost = 3000
    var investSkyscraperAmount = 0
    
    var locationManager:CLLocationManager = CLLocationManager()
    
     /////////////////////////////CODE///////////////////////////////

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        uiMoneyDisplay()
        
        self.locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        
        Timer.scheduledTimer(timeInterval: 1.0,  target: self, selector: #selector(Count), userInfo: nil ,  repeats: true)
        
        gpsData()

    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        manager.stopUpdatingLocation()
    }
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status != CLAuthorizationStatus.denied{
            locationManager.startUpdatingLocation()
        }
    }
    //We grab altitude and speed and then use it to implement ingame benefits with this function.
    func gpsData() {
        
        var speed: CLLocationSpeed = CLLocationSpeed()
        speed = speed + 0.0
        
        if let altHeight = locationManager.location?.altitude {
            
            if altHeight <= 50 {
                investHouseCost = investHouseCost / 2
            }
            if altHeight >= 51 && altHeight <= 200 {
                investSkyscraperCost = investSkyscraperCost / 2
            }
            if altHeight >= 201 {
                investAirplaneCost = investAirplaneCost / 2
            }
            if speed > 10.0 {
                investTrainCost = investTrainCost / 2
            }
            print(altHeight)
            print(speed)
        }
    }
    
    // This is the money earning click area.
    @IBAction func btnClickArea(_ sender: UIButton) {
        totalMoney += clickMoney
        uiMoneyDisplay()
        lblSystemText.text = "You earned \(clickMoney) money!"
        //print(locationManager.location?.altitude)
    }
    
    // Next four button functions are for the procurement of ingame investments.
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
    
    @IBAction func btnBuyAirplane(_ sender: UIButton) {
        if totalMoney >= investAirplaneCost {
            totalMoney -= investAirplaneCost
            investAirplaneAmount += 50
            investAirplaneCost *= 2
            clickMoney += investAirplaneAmount
            
            lblSystemText.text = "Airplane purchased!"
            uiMoneyDisplay()
        }
        else {
            lblSystemText.text = "Not enough money!"
        }
    }
    
    @IBAction func btnBuySkyscraper(_ sender: UIButton) {
        if totalMoney >= investSkyscraperCost {
            totalMoney -= investSkyscraperCost
            investSkyscraperAmount += 100
            investSkyscraperCost *= 2
            clickMoney += investSkyscraperAmount
            
            lblSystemText.text = "Skyscraper purchased!"
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
        lblInvestAirplaneCost.text = "Cost: $\(investAirplaneCost)"
        lblInvestSkyscraperCost.text = "Cost: $\(investSkyscraperCost)"
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
        if investAirplaneAmount >= 1 {
            lblInvestAirplaneAmount.text = "Income: $\(investAirplaneAmount)"
        }
        else{
            lblInvestAirplaneAmount.text = "Income: $0"
        }
        if investSkyscraperAmount >= 1 {
            lblInvestSkyscraperAmount.text = "Income: $\(investSkyscraperAmount)"
        }
        else{
            lblInvestSkyscraperAmount.text = "Income: $0"
        }
    }
    
    // The timer which ends play session and activates segue at 0.
    @objc func Count()
    {
        timeCount  -= 1
        if timeCount == 0
        {
            performSegue(withIdentifier: "endSegue", sender: self)
        }
        lblTimer.text = String(timeCount)
    }
    
    // Sending the final score to next page.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let endSegue = "endSegue"
        
        if segue.identifier == endSegue {
            let destinationVC = segue.destination as! EndViewController
            
            destinationVC.currentScore = totalMoney
        }
        
    }
}

