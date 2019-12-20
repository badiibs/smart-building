//
//  AirCondViewController.swift
//  Smart Building
//
//  Created by admin on 16/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit


class AirCondViewController: UIViewController {
    
    @IBOutlet weak var powerButton: UIButton!
    @IBOutlet weak var stateLabel: UILabel!
    
    
    let urlGet =  "http://159.8.95.102/api/Climatiseurs/getClimatiseurByIdStatique"
    let urlPut = URL(string: "http://159.8.95.102/api/Climatiseurs/updateEtatTest?access_token=JaWErsZBo0OGvvKL3nONPcRz8Wgds4K9oV6rPdZNl51HiofhIna0rpWahOscGsjC")!
    var state = ""

    let onImage = UIImage(named: "airCondOn") as UIImage?
    let offImage = UIImage(named: "airCondOff") as UIImage?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Air Conditioner"

        performRequest(urlString: urlGet)
        wait()
        updateButtonView()
        print("main \(state)")
        
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(airConData: safeData)
                }
            }
            task.resume()
        }
    }

    func parseJSON(airConData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(AirConddata.self, from: airConData)
            //print(decodedData.etat)
            state = decodedData.etat
            print("json \(state)")
        } catch {
            print(error)
        }
    }

    func putRequest() {
         var request = URLRequest(url: urlPut)
         request.httpMethod = "PUT"
         let session = URLSession(configuration:URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)

         let dataTask = session.dataTask(with: request) { (data, response, error) -> Void in

             if error != nil {

                 print("put error !")
             }
             else {

                self.performRequest(urlString: self.urlGet)
                //print("putsuccess \(self.state)")
             }
         }
         dataTask.resume()

     }

    func updateButtonView() {

        if state == "ON"{
             powerButton.setImage(onImage, for: .normal)
            stateLabel.text = "ON"
        } else if state == "OFF" {
             powerButton.setImage(offImage, for: .normal)
            stateLabel.text = "OFF"
        } else {
            stateLabel.text = "Connection failed.."
        }
    }

    func wait(){
        do {
            sleep(1)
        }
    }
    
   
     
    @IBAction func powerButtonPressed() {
        putRequest()
        wait()
       updateButtonView()
    }

}

