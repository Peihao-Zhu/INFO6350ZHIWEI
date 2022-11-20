//
//  ViewController.swift
//  Weather forecast
//
//  Created by 竺培豪 on 11/19/22.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController ,CLLocationManagerDelegate ,UITableViewDelegate,UITableViewDataSource{

    
    let locationManager = CLLocationManager()
    
    var lat: CLLocationDegrees?
    var lon: CLLocationDegrees?
    var arr : [String] = [String]()
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var inputCityName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestLocation()
    }
    
    
    // get your city weather
    @IBAction func getLatAndLon(_ sender: Any) {
        var url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?locations="
        url += String(format: "%f",lat!) + "," + String(format: "%f",lon!)+"&aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=AYQR6QM5KHFYVPH9M4EXXJUCC"
        
        AF.request(url).responseJSON { responseData in
            if responseData.error != nil {
                print(responseData.error!)
                return
                
            }
            self.arr = [String]()
            
            let weatherData = JSON(responseData.data as Any)
            let forecastValues =  weatherData["locations"][String(format: "%f",self.lat!)+","+String(format: "%f",self.lon!)]["values"]
            print(forecastValues.count)
            for forecast in forecastValues {
                let forecastJSON = JSON(forecast.1)
                let temp = forecastJSON["temp"].floatValue
                let condition = forecastJSON["conditions"].stringValue
                let str = "tempature =\(temp) F,\(condition)"
                print(forecast)
                self.arr.append(str)
                
            }
            self.tableView.reloadData()
        }
    

        
    }
    
    //get the weather of  city
    @IBAction func getCityWeather(_ sender: Any) {
        let cityName = inputCityName.text
        var url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?locations="
        url += (cityName ?? "")+"&aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=AYQR6QM5KHFYVPH9M4EXXJUCC"

        AF.request(url).responseJSON { responseData in
            if responseData.error != nil {
                print(responseData.error!)
                return

            }
            self.arr = [String]()

            let weatherData = JSON(responseData.data as Any)
            let forecastValues =  weatherData["locations"][String(cityName ?? "")]["values"]
            print(forecastValues.count)
            for forecast in forecastValues {
                let forecastJSON = JSON(forecast.1)
                let temp = forecastJSON["temp"].floatValue
                let condition = forecastJSON["conditions"].stringValue
                let str = "tempature =\(temp) F,\(condition)"
                print(forecast)
                self.arr.append(str)

            }
            self.tableView.reloadData()
        }


    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = arr[indexPath.row]

       return cell
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else { return }
           
           lat = location.coordinate.latitude
           lon = location.coordinate.longitude
           
           print(lat)
           print(lon)
           
       }

       @IBAction func getLocation(_ sender: Any) {
           locationManager.requestLocation()
       }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print(error)
       }
       
     


}

