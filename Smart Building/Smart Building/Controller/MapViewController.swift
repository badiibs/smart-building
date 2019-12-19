//
//  MapViewController.swift
//  Smart Building
//
//  Created by admin on 13/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var roomName = ""
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(roomName)
        configureLocationServices()
    }
    
    func configureLocationServices() {
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdate(locationManager: locationManager)
        }
    }
    
    
    func beginLocationUpdate(locationManager: CLLocationManager){
            mapView.centerCoordinate = .init(latitude: 36.85457212823548, longitude: 10.209838299117497)
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
   
    func zoomLatetstLocation(with coordinate: CLLocationCoordinate2D) {
            let zoomRegion = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(zoomRegion, animated: true)
        }
        
      
    func addAllAnnotations() {
            addWeatherSAnnotation()
            addGLAnnotation()
            addSWAnnotation()
            addSRAnnotation()
            addWorkSAnnotation()
            addMRAnnotation()
        }
        
      
    func addWeatherSAnnotation() {
                let weatherStationAnnotation = MKPointAnnotation()
                weatherStationAnnotation.title = "Weather Station"
            weatherStationAnnotation.coordinate=CLLocationCoordinate2D(latitude:36.85457212823548,longitude:10.209448310117683)
                mapView.addAnnotation(weatherStationAnnotation)
                   }
                  
     
    func addGLAnnotation(){
                let greenLandAnnotation = MKPointAnnotation()
                greenLandAnnotation.title = "Landa LoRa"
                greenLandAnnotation.coordinate = CLLocationCoordinate2D(latitude:36.85427724347005 , longitude:10.209838299117497)
                mapView.addAnnotation(greenLandAnnotation)
                   }
                   
    func addSWAnnotation() {
                let smartWaterAnnotation = MKPointAnnotation()
                smartWaterAnnotation.title = "Smart Water"
                smartWaterAnnotation.coordinate = CLLocationCoordinate2D(latitude: 36.85444815168929 , longitude:10.209624916817507)
                mapView.addAnnotation(smartWaterAnnotation)
                   }
       
    func addSRAnnotation() {
                let systemRoomAnnotation = MKPointAnnotation()
                systemRoomAnnotation.title = "System Room"
                systemRoomAnnotation.coordinate = CLLocationCoordinate2D(latitude: 36.85449652503426 , longitude:10.209948374460897)
                mapView.addAnnotation(systemRoomAnnotation)
                   }
                
    func addWorkSAnnotation() {
                let workSpaceAnnotation = MKPointAnnotation()
                workSpaceAnnotation.title = "Work Space"
                workSpaceAnnotation.coordinate = CLLocationCoordinate2D(latitude: 36.853988276422996 , longitude:10.21014847144436)
                mapView.addAnnotation(workSpaceAnnotation)
                   }
       
    func addMRAnnotation() {
          let meetingRoomAnnotation = MKPointAnnotation()
          meetingRoomAnnotation.title = "Meeting Room"
          meetingRoomAnnotation.coordinate = CLLocationCoordinate2D(latitude: 36.854854671273735 ,longitude:10.209760095960906)
          mapView.addAnnotation(meetingRoomAnnotation)
          }
    }

    extension MapViewController: CLLocationManagerDelegate {
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           print("Did get latest location")
            let latestLocation: CLLocationCoordinate2D = .init(latitude: 36.854815, longitude: 10.210048)
            zoomLatetstLocation(with: latestLocation)
            switch roomName {
            case "Localisation": addAllAnnotations()
            case "Weather Station": addWeatherSAnnotation()
            case "Landa LoRa": addGLAnnotation()
            case "Smart Water": addSWAnnotation()
            case "Work Space": addWorkSAnnotation()
            case "System Room": addSRAnnotation()
            case "Meeting Rooom": addMRAnnotation()
            default:
                print("Error getting room name: \(roomName)")
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           print("The status changed")
            if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdate(locationManager: manager)
            }
        }
    
}
