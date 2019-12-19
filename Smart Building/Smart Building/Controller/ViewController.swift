//
//  ViewController.swift
//  Smart Building
//
//  Created by admin on 06/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //URLs
    let urlWStGet =  "http://159.8.95.102/api/devices/getDeviceLast?applicationID=2"
    let urlGLtGet =  "http://159.8.95.102/api/devices/getDeviceLast?applicationID=5"
    let urlWSpGet =  "http://159.8.95.102/api/devices/getDeviceLast?applicationID=6"

    
    let roomName = ["Weather Station","Landa LoRa","Smart Water","Work Space","Salle System","Salle Reunion", "Localisation","Air Conditioner"]
    var roomTemperature: [String] = [""]
    var roomHumidity: [String] = [""]
    var roomPressure: [String] = [""]
    
    //variables
    //Weather Station variables
    var wStTemperature: Double = 0.0
    var wStHumidity: Double = 0.0
    var wStDirection: String = ""
    //Green Land variables
    var gLTemperature: String = ""
    var gLHumidity: String = ""
    var gLWaterSensor: String = ""
    //Work Space variables
    var wSpTemperature: Double = 0.0
    var wSpHumidity: Double = 0.0
    var wSpPressure: Double = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateValuesArrays()
        wait()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "RoomsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "roomCell")
        collectionView.register(UINib(nibName: "MapAndAirCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "extraCell")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondDashboard" {
            let destVC = segue.destination as! SecondDashboardViewController
            destVC.roomname = sender as! String
        }
        else if segue.identifier == "goToAllPosition" {
            let destVCC = segue.destination as! MapViewController
            destVCC.roomName = sender as! String
        }
//        else if segue.identifier == "goToAirCond" {
//            let destVC = segue.destination as! AirCondViewController
//        }
    }
    
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
                 makeEmptyArrays()
                wStTemperature = decodedData.object.Temperature
                 roomTemperature[0] = "\(wStTemperature) °C"
                wStHumidity = decodedData.object.RH
                 roomHumidity[0] = "Humidity : \(wStHumidity) %"
                //wStDirection = decodedData.object.direction
                 wStDirection = "Nord"
                 roomPressure[0] = "Direction : \(wStDirection)"
            case "Landa LoRa":
                let decodedData = try decoder.decode(LandaLora.self, from: deviceData)
                gLTemperature = decodedData.object.Temperature
                roomTemperature.append("\(gLTemperature) °C")
                gLHumidity = decodedData.object.Humidity
                roomHumidity.append("humidity : \(gLHumidity) %")
                gLWaterSensor = decodedData.object.WaterSensor
                roomPressure.append("Level : \(gLWaterSensor) mm")
            case "Work Space":
                let decodedData = try decoder.decode(WorkSpace.self, from: deviceData)
                wSpTemperature = decodedData.object.temperature
                roomTemperature.append("\(wSpTemperature) °C")
                wSpHumidity = decodedData.object.humidity
                roomHumidity.append("Humidity : \(wSpHumidity) %")
                wSpPressure = decodedData.object.pressure
                roomPressure.append("Pressure : \(wSpPressure) bar")

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
    
    func updateValuesArrays() {
        performRequest(urlString: urlWStGet, deviceName: "Weather Station")
        wait()
        performRequest(urlString: urlGLtGet, deviceName: "Landa LoRa")
        wait()
        addEmptyStringToArray()
        performRequest(urlString: urlWSpGet, deviceName: "Work Space")
        wait()
        addEmptyStringToArray()
        addEmptyStringToArray()
        addEmptyStringToArray()
        addEmptyStringToArray()
        print(roomTemperature)

    }
    
    func addEmptyStringToArray(){
        roomTemperature.append("-- °C")
        roomHumidity.append("Humidity : - %")
        roomPressure.append("Pressure : - bar")
    }
    
    func makeEmptyArrays() {
        roomTemperature = [""]
        roomHumidity = [""]
        roomPressure = [""]
    }

}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let room = roomName[indexPath.row]
        let temperature = roomTemperature[indexPath.row]
        let humidity = roomHumidity[indexPath.row]
        let pressure = roomPressure[indexPath.row]
        
        if (indexPath.item < 6) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roomCell", for: indexPath) as! RoomsCollectionViewCell
            
            cell.roomNameLabel.text = room
            cell.roomTemperature.text = temperature
            cell.roomHumidity.text = humidity
            cell.roomPression.text = pressure
            
            cell.roomCellsView.layer.cornerRadius = 10
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "extraCell", for: indexPath) as! MapAndAirCollectionViewCell
            cell.title.text = room
            if indexPath.item == 6 {
                cell.imageView.image = UIImage(named: "localisation")
            } else {
                 cell.imageView.image = UIImage(named: "air conditioner")
            }
            cell.roomExtraCellView.layer.cornerRadius = 10
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.item < 6) {
            print(indexPath.item)
            let nextVC = SecondDashboardViewController()
            var room = nextVC.roomname
            room = roomName[indexPath.item]
            print(room)
            performSegue(withIdentifier: "goToSecondDashboard", sender: room)
        } else if indexPath.item == 6 {
            let nextVC = MapViewController()
            var room = nextVC.roomName
            room = roomName[indexPath.item]
            performSegue(withIdentifier: "goToAllPosition", sender: room)
        } else if indexPath.item == 7 {
            performSegue(withIdentifier: "goToAirCond", sender: self)
        }
        
    }
}
