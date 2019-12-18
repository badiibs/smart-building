//
//  SecondDashboardViewController.swift
//  Smart Building
//
//  Created by admin on 10/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class SecondDashboardViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var roomname = ""
    
    var weatherStation = WeatherStation()
    //Cell Arrays
    var cellIconsTable: [String] = []
      var cellTitleLabel: [String] = []
      var cellDeviceValue: [String] = []
    
    //Weather Station arrays
    let weatherStationIconsTable = ["temperature","humidity","rainfull","speed","direction","time","position"]
    let weatherStationTitleLabel = ["Temperature","Humidity","Rainfull","Speed","Direction","12:15:15 17 12 12","Position"]
    var weatherstationDeviceValues: [String] = []
    
    //Green Land arrays
    let greenLandIconsTable = ["temperature","humidity","moisture","water sensor","battery","time","position"]
    let greenLandTitleLabel = ["Temperature","Humidity","Moisture","Water Sensor","Battery","12:15:15 17 12 12","Position"]
    var greenLandDeviceValues: [String] = []
    
    //Smart Water arrays
    let smartWaterIconsTable = ["temperature","humidity","co2","ph","conductivity","luminosity","battery","time","position"]
    let smartWaterTitleLabel = ["Temperature","Humidity","CO2","pH Meter","Conductivity","Luminosity","Battery","12:15:15 17 12 12","Position"]
    var smartWaterDeviceValues: [String] = []
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCellArray()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "firstCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPosition" {
            let destVCC = segue.destination as! MapViewController
            destVCC.roomName = sender as! String
        }
    }
    
    func updateCellArray() {
        switch roomname {
        case "Weather Station":
            weatherStationTabs()
        case "Green Land": greenLandArrays()
        case "Smart Water": smartWaterArrays()
        default:
            print("error updating Cell Array")
        }
    }
    
    func weatherStationTabs() {
        weatherStation.updateValues()
        weatherstationDeviceValues = [String(weatherStation.temperature), String(weatherStation.humidity),String(weatherStation.rainfall),String(weatherStation.speed),String(weatherStation.direction),"",""]
      cellIconsTable = weatherStationIconsTable
      cellTitleLabel = weatherStationTitleLabel
      cellDeviceValue = weatherstationDeviceValues
       
    }
    
    func greenLandArrays() {
        cellIconsTable = greenLandIconsTable
        cellTitleLabel = greenLandTitleLabel
        cellDeviceValue = greenLandDeviceValues
    }
    
    func smartWaterArrays(){
        cellIconsTable = smartWaterIconsTable
        cellTitleLabel = smartWaterTitleLabel
        cellDeviceValue = smartWaterDeviceValues
    }
    

}
extension SecondDashboardViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellIconsTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! FirstTableViewCell
        cell.firstCellIcon.image = UIImage(named: "\(cellIconsTable[indexPath.row])")
        cell.firstCellLabel.text = cellTitleLabel[indexPath.row]
        cell.firstCellValueLabel.text = String(cellDeviceValue[indexPath.row])
        cell.firstCellView.layer.cornerRadius = 10
        return cell
    }
    
    
}
extension SecondDashboardViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cellTitleLabel[indexPath.item] == "Position" {
          let nextVC = MapViewController()
          var room = nextVC.roomName
          room = roomname
            performSegue(withIdentifier: "goToPosition", sender: room)
        }
    }
}
