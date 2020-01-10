//
//  ViewController.swift
//  LocationAware
//
//  Created by MacStudent on 2020-01-09.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var latiLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var attitudeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        latiLabel.text = String(location.coordinate.latitude)
        longLabel.text = String(location.coordinate.longitude)
        speedLabel.text = String(location.speed)
        courseLabel.text = String(location.course)
        attitudeLabel.text = String(location.altitude)
        
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
        if let error = error{
            print(error)
        }else{
            if let placemark = placemarks?[0]{
                var address = ""
                if placemark.subThoroughfare != nil{
                    address += placemark.subThoroughfare! + "\n"
                }
                
                if placemark.thoroughfare != nil{
                    address += placemark.thoroughfare! + "\n"
                }
    
                if placemark.subLocality != nil{
                    address += placemark.subLocality! + "\n"
                }
                
                if placemark.subAdministrativeArea != nil{
                   address += placemark.subAdministrativeArea! + "\n"
                }
                
                if placemark.postalCode != nil{
                    address += placemark.postalCode! + "\n"
                }
                
                if placemark.country != nil{
                    address += placemark.country! + "\n"
                }
                
                self.addressLabel.text = address
                }
            }
        }
    }
}
