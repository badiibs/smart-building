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
    var nextTemperature = 0.0
    //Cell Arrays
    var cellIconsTable: [String] = []
      var cellTitleLabel: [String] = []
      var cellDeviceValue: [String] = []
   //Weather Station variables
    var wStTemperature: Double = 0.0
    var wStHumidity: Double = 0.0
    var wStDirection: String = ""
    var wStRainfall: Int = 0
    var wStSpeed: Int = 0
    var wStTime: String = ""
    //Green Land variables
    var gLTemperature: String = ""
    var gLHumidity: String = ""
    var gLMoisture: String = ""
    var gLWaterSensor: String = ""
    var gLTime: String = ""
    var gLBatteryLevel: Double = 0.0
    //Work Space variables
    var wSpTemperature: Double = 0.0
    var wSpHumidity: Double = 0.0
    var wSpPressure: Double = 0.0
    var wSpTime: String = ""
    var wSpBattery: Double = 0.0
    //Weather Station arrays
    let urlWStGet =  "http://159.8.95.102/api/devices/getDeviceLast?applicationID=2"

    let weatherStationIconsTable = ["temperature","humidity","rainfull","speed","direction","time","position"]
    let weatherStationTitleLabel = ["Temperature","Humidity","Rainfull","Speed","Direction","12:15:15 17 12 12","Position"]
    var weatherstationDeviceValues: [String] = []
    
    //Green Land arrays
    let urlGLtGet =  "http://159.8.95.102/api/devices/getDeviceLast?applicationID=5"

    let greenLandIconsTable = ["temperature","humidity","moisture","water sensor","battery","time","position"]
    let greenLandTitleLabel = ["Temperature","Humidity","Moisture","Water Sensor","Battery","12:15:15 17 12 12","Position"]
    var greenLandDeviceValues: [String] = []
    
    //Smart Work Space arrays
    let urlWSpGet =  "http://159.8.95.102/api/devices/getDeviceLast?applicationID=6"

    let workSpaceIconsTable = ["temperature","humidity","pressure","battery","time","position"]
    let workSpaceTitleLabel = ["Temperature","Humidity","Pressure","Battery","","Position"]
    var workSpaceDeviceValues: [String] = []
    

    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = roomname
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
        else if segue.identifier == "goToChart" {
            let destVC = segue.destination as! ChartViewController
            destVC.temperature = sender as! Double
        }
    }
    
    func updateCellArray() {
        switch roomname {
        case "Weather Station":
            weatherStationTabs()
        case "Landa LoRa": greenLandArrays()
        case "Work Space": workSpaceArrays()
        default:
            print("error updating Cell Array")
        }
    }
    
    func weatherStationTabs() {
        performRequest(urlString: urlWStGet, deviceName: "Weather Station")
        wait()
        weatherstationDeviceValues = ["\(wStTemperature) °C", "\(wStHumidity) %",String(wStRainfall),String(wStSpeed),String(wStDirection),"",""]
        
      cellIconsTable = weatherStationIconsTable
      cellTitleLabel = weatherStationTitleLabel
        cellTitleLabel[5] = wStTime
      cellDeviceValue = weatherstationDeviceValues
        
       
    }
    
    func greenLandArrays() {
        performRequest(urlString: urlGLtGet, deviceName: "Landa LoRa")
        wait()
        greenLandDeviceValues = ["\(gLTemperature) °C","\(gLHumidity) %","\(gLMoisture) %","\(gLWaterSensor) mm","\(Double(round(10*gLBatteryLevel)/10)) %","",""]

        cellIconsTable = greenLandIconsTable
        cellTitleLabel = greenLandTitleLabel
        cellTitleLabel[5] = gLTime
        cellDeviceValue = greenLandDeviceValues
    }
    
    func workSpaceArrays(){
        performRequest(urlString: urlWSpGet, deviceName: "Work Space")
               wait()
        workSpaceDeviceValues = ["\(wSpTemperature) °C","\(wSpHumidity) %","\(wSpPressure) bar","\(Double(round(10*wSpBattery)/10)) %","",""]
        cellIconsTable = workSpaceIconsTable
        cellTitleLabel = workSpaceTitleLabel
        cellTitleLabel[4] = wSpTime
        cellDeviceValue = workSpaceDeviceValues
    }
    
//Weather Station Request
    func performRequest(urlString: String, deviceName: String) {
           if let url = URL(string: urlString) {
               let session = URLSession(configuration: .default)
               let task = session.dataTask(with: url) { (data, response, error) in
                   if error != nil {
                       print(error!)
                       return
                   }
                   if let safeData = data {
                      self.parseJSON(deviceData: safeData,deviceName: deviceName)
                   }
               }
               task.resume()
           }
       }

    func parseJSON(deviceData: Data, deviceName: String) {
           let decoder = JSONDecoder()
           do {
            switch deviceName {
            case "Weather Station":
                 let decodedData = try decoder.decode(WeatherStation.self, from: deviceData)
                              wStTemperature = decodedData.object.Temperature
                            nextTemperature = Double(wStTemperature) as! Double
                           wStHumidity = decodedData.object.RH
                           wStRainfall = decodedData.object.rainfall
                           wStSpeed = decodedData.object.speed
                          // wStDirection = decodedData.object.direction
                           wStDirection = "Nord"
                           wStTime = decodedData.object.Time
            case "Landa LoRa":
                let decodedData = try decoder.decode(LandaLora.self, from: deviceData)
                gLTemperature = decodedData.object.Temperature
                nextTemperature = Double(gLTemperature) as! Double
                gLHumidity = decodedData.object.Humidity
                gLMoisture = decodedData.object.Moisture
                gLWaterSensor = decodedData.object.WaterSensor
                gLTime = decodedData.object.Time
                gLBatteryLevel = decodedData.object.Battery_Level
            case "Work Space":
                let decodedData = try decoder.decode(WorkSpace.self, from: deviceData)
                print("work space temperature is :\(wSpTemperature)")
                wSpTemperature = decodedData.object.temperature
                nextTemperature = Double(wSpTemperature) as! Double
                wSpHumidity = decodedData.object.humidity
                wSpPressure = decodedData.object.pressure
                wSpTime = decodedData.object.Time
                wSpBattery = decodedData.object.battery

            default:
                print("Error switch parse json")
            }
              
           } catch {
               print(error)
           }
       }
    
     func wait(){
            do {
                sleep(1)
            }
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
        cell.firstCellView.layer.cornerRadius = 15
        cell.firstCellView.layer.borderWidth = 3.0
        cell.firstCellView.layer.borderColor = UIColor.black.cgColor
        //cell.layer.borderColor = UIColor.black.cgColor
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
        else if cellTitleLabel[indexPath.item] == "Temperature" {
              let nextVC = ChartViewController()
              //var room = nextVC.roomName
              var temperature = nextVC.temperature
              //room = roomname
              temperature = nextTemperature
                performSegue(withIdentifier: "goToChart", sender: temperature)
        }
    }
}


