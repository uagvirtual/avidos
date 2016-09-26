//
//  PJMapViewController.swift
//  PuntoJalisco
//
//  Created by José Félix Olivares Estrada on 9/9/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit

class PJMapViewController: UIViewController, GMSMapViewDelegate {

    let response = "[{\"RUTA\":\"368\",\"LAT\":\"20.70808167\",\"LNG\":\"103.36826833\",\"FECHALOG\":\"19/07/2016 12:00:00 a. m.\",\"HORA\":\"14:05:36\",\"IDHARDWARE\":\"1001\",\"NUMCAMION\":\"1001\",\"DISTANCIA\":\"4057.1374051846\",\"SATURACION\":\"G\"},{\"RUTA\":\"368\",\"LAT\":\"20.61541500\",\"LNG\":\"103.29106667\",\"FECHALOG\":\"19/07/2016 12:00:00 a. m.\",\"HORA\":\"00:11:34\",\"IDHARDWARE\":\"1002\",\"NUMCAMION\":\"1002\",\"DISTANCIA\":\"10220.4152518387\",\"SATURACION\":\"G\"}]"
    var routesArray:[PJRouteObject] = []
    
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        let parsedRoutes = JSONParser().parseJSON(response)
        for eachRoute in parsedRoutes{
            let route = PJRouteObject.init(route: eachRoute as! [String : String])
            self.routesArray.append(route)
        }
        print(self.routesArray) 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - CLLocationManagerDelegate
extension PJMapViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            locationManager.stopUpdatingLocation()
        }
        
    }
}