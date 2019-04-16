//
//  ViewController.swift
//  Speed Investor
//
//  Created by Edgar Palic on 2/25/19.
//  Copyright © 2019 Edgar Palic. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

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
    var investHouseAmount = 0
    var investTrainCost = 500
    var investTrainAmount = 0
    var investAirplaneCost = 1000
    var investAirplaneAmount = 0
    var investSkyscraperCost = 2000
    var investSkyscraperAmount = 0
    
    var locationManager:CLLocationManager = CLLocationManager()
    var bonusColor = UIColor(red: 102/255, green: 250/255, blue: 51/255, alpha: 0.75)
    var originalColor = UIColor(red: 125/255, green: 209/255, blue: 229/255, alpha: 0.75)
    var audioPlayer: AVAudioPlayer!
    var audioPlayer2: AVAudioPlayer!
    var coordinates: CGPoint!
    
     /////////////////////////////CODE///////////////////////////////

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        uiMoneyDisplay()
        lblSystemText.text = "Start working!"
        
        self.locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        
        Timer.scheduledTimer(timeInterval: 1.0,  target: self, selector: #selector(Count), userInfo: nil ,  repeats: true)
        
        gpsData()
        backgroundMusic()

    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        manager.stopUpdatingLocation()
    }
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status != CLAuthorizationStatus.denied{
            locationManager.startUpdatingLocation()
        }
    }
    //We grab altitude and movement speed and then use it to implement ingame benefits with this function.
    func gpsData() {
        
        var speed: CLLocationSpeed = CLLocationSpeed()
        
        if let altHeight = locationManager.location?.altitude {
            
            if altHeight <= 50 {
                investHouseCost = investHouseCost / 2
                btnBuyHouse.backgroundColor = bonusColor
            } else {
                btnBuyHouse.backgroundColor = originalColor
            }
            
            if altHeight >= 51 && altHeight <= 200 {
                investSkyscraperCost = investSkyscraperCost / 2
                btnBuySkyscraper.backgroundColor = bonusColor
            } else {
                btnBuySkyscraper.backgroundColor = originalColor
            }
            
            if altHeight >= 201 {
                investAirplaneCost = investAirplaneCost / 2
                btnBuyAirplane.backgroundColor = bonusColor
            } else {
                btnBuyAirplane.backgroundColor = originalColor
            }
            
            if speed > 10.0 {
                investTrainCost = investTrainCost / 2
                btnBuyTrain.backgroundColor = bonusColor
            } else {
                btnBuyTrain.backgroundColor = originalColor
            }
            print("Altitude \(altHeight)")
            print("Speed \(speed)")
        }
    }
    
    // This is the money earning click area.
    @IBAction func btnClickArea(_ sender: UIButton) {
        numberFly(clickMoney)
        totalMoney += clickMoney
        uiMoneyDisplay()
        lblSystemText.text = "You earned \(clickMoney) money!"
    }
    
    // Next four button functions are for the procurement of ingame investments.
    @IBAction func btnBuyHouse(_ sender: UIButton) {
        
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.5, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
        })
        
        if totalMoney >= investHouseCost {
            totalMoney -= investHouseCost
            investHouseAmount += 1
            investHouseCost *= 2
            clickMoney = clickMoney + 1
            lblSystemText.text = "House purchased!"
            uiMoneyDisplay()
            buttonSound()
        }
        else{
            lblSystemText.text = "Not enough money!"
        }
    }
    
    @IBAction func btnBuyTrain(_ sender: UIButton) {
        
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.5, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
        })
        
        if totalMoney >= investTrainCost {
            totalMoney -= investTrainCost
            investTrainAmount += 1
            investTrainCost *= 2
            clickMoney = clickMoney + 10
            
            lblSystemText.text = "Train purchased!"
            uiMoneyDisplay()
            buttonSound()
        }
        else {
            lblSystemText.text = "Not enough money!"
        }
    }
    
    @IBAction func btnBuyAirplane(_ sender: UIButton) {
        
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.5, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
        })
        
        if totalMoney >= investAirplaneCost {
            totalMoney -= investAirplaneCost
            investAirplaneAmount += 1
            investAirplaneCost *= 2
            clickMoney = clickMoney + 50
            
            lblSystemText.text = "Airplane purchased!"
            uiMoneyDisplay()
            buttonSound()
        }
        else {
            lblSystemText.text = "Not enough money!"
        }
    }
    
    @IBAction func btnBuySkyscraper(_ sender: UIButton) {
        
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.5, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
        })
        
        if totalMoney >= investSkyscraperCost {
            totalMoney -= investSkyscraperCost
            investSkyscraperAmount += 1
            investSkyscraperCost *= 2
            clickMoney = clickMoney + 100
            
            lblSystemText.text = "Skyscraper purchased!"
            uiMoneyDisplay()
            buttonSound()
        }
        else {
            lblSystemText.text = "Not enough money!"
        }
    }
    
    // This will actively display information regarding investments on the investment buttons. Called in multiple places.
    func uiMoneyDisplay(){
        lblTotalMoney.text = "Money: $\(totalMoney)"
        lblInvestHouseCost.text = "Cost: $\(investHouseCost)"
        lblInvestTrainCost.text = "Cost: $\(investTrainCost)"
        lblInvestAirplaneCost.text = "Cost: $\(investAirplaneCost)"
        lblInvestSkyscraperCost.text = "Cost: $\(investSkyscraperCost)"
        btnClickArea.setTitle("Income $\(clickMoney)", for: .normal)
        
        if investHouseAmount >= 1 {
        lblInvestHouseAmount.text = "Amount: \(investHouseAmount)"
        }
        else{
            lblInvestHouseAmount.text = "Amount: 0"
        }
        if investTrainAmount >= 1 {
            lblInvestTrainAmount.text = "Amount: \(investTrainAmount)"
        }
        else{
            lblInvestTrainAmount.text = "Amount: 0"
        }
        if investAirplaneAmount >= 1 {
            lblInvestAirplaneAmount.text = "Amount: \(investAirplaneAmount)"
        }
        else{
            lblInvestAirplaneAmount.text = "Amount: 0"
        }
        if investSkyscraperAmount >= 1 {
            lblInvestSkyscraperAmount.text = "Amount: \(investSkyscraperAmount)"
        }
        else{
            lblInvestSkyscraperAmount.text = "Amount: 0"
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
        
        audioPlayer2.stop()
        audioPlayer2.currentTime = 0
        
        let endSegue = "endSegue"
        
        if segue.identifier == endSegue {
            let destinationVC = segue.destination as! EndViewController
            
            destinationVC.currentScore = totalMoney
        }
    }
    
    // Some button sound and background music functions.
    func buttonSound(){
        let soundURL = Bundle.main.url(forResource: "ching", withExtension: "wav")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch {
            print(error)
        }
        audioPlayer.play()
        print("ching")
    }
    
    func backgroundMusic(){
        let soundURL = Bundle.main.url(forResource: "bgmusic", withExtension: "mp3")
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch {
            print(error)
        }
        audioPlayer2.play()
        print("bg music starts")
    }
    
    // This function creates a floating label animation from the center of the screen.
    func numberFly(_ clickMoney: Int) {
        let label = UILabel(frame: CGRect(x: self.view.frame.width / 2, y: self.view.frame.height / 2, width: 100, height: 50))
        label.text = "$\(clickMoney)"
        label.font = UIFont(name: "AvenirNext-Medium", size: 45)
        label.textColor = UIColor.white
        
        self.view.addSubview(label)
        
        let random = arc4random_uniform(100)
        
        UIView.animate(withDuration: 1.5, animations: {
            label.center.y -= 250
            label.center.x += -50 + CGFloat(random)
            label.alpha = 0
        })
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
            label.removeFromSuperview()
        })
    }
}

