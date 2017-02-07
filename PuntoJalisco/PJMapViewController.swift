//
//  PJMapViewController.swift
//  PuntoJalisco
//
//  Created by José Félix Olivares Estrada on 9/9/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit
import Alamofire

class PJMapViewController: UIViewController, GMSMapViewDelegate {

    let response = "[{\"RUTA\":\"368\",\"LAT\":\"20.70808167\",\"LNG\":\"-103.36826833\",\"FECHALOG\":\"19/07/2016 12:00:00 a. m.\",\"HORA\":\"14:05:36\",\"IDHARDWARE\":\"1001\",\"NUMCAMION\":\"1001\",\"DISTANCIA\":\"4057.1374051846\",\"SATURACION\":\"G\"},{\"RUTA\":\"368\",\"LAT\":\"20.690146\",\"LNG\":\"-103.315151\",\"FECHALOG\":\"19/07/2016 12:00:00 a. m.\",\"HORA\":\"00:11:34\",\"IDHARDWARE\":\"1002\",\"NUMCAMION\":\"1002\",\"DISTANCIA\":\"10220.4152518387\",\"SATURACION\":\"R\"}]"
    var routesArray:[PJRouteObject] = []
    var markersArray:[GMSMarker] = []
    var path:GMSMutablePath = GMSMutablePath()
    
    let locationPath = Constants.Paths.mainPath + Constants.Paths.locationPath
//    var params:[String:String] = [Constants.Location.routeKey:"368", Constants.Location.latKey:"20.671628", Constants.Location.lonKey:"-103.36867"]
    var params:[String:String] = [:]
    
    @IBOutlet weak var selectRouteView: UIView!
    @IBOutlet weak var routeNameLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    var timer:Timer = Timer()
    var devMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        devMode = UserDefaults.standard.bool(forKey: Constants.isDevMode)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        routeNameLabel.text = "Seleccionar ruta"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PJMapViewController.selectRoute(_:)))
        selectRouteView.addGestureRecognizer(tap)
    }
    
    func selectRoute(_ sender: UITapGestureRecognizer? = nil) {
        tabBarController?.selectedIndex = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let name = PJRouteManager.sharedInstance.currentRoute.routeName {
            params[Constants.Location.routeKey] = name
            routeNameLabel.text = "Ruta " + name
            self.mapView.clear()
            getLocation()
            timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(getLocation), userInfo: nil, repeats: true)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        timer.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLocation(){
        if routesArray.count > 0{
            routesArray.removeAll()
        }
        
        if !devMode {
            print("params: \(params)")
            self.mapView.clear()
            print("[ROUTES] - getLocation started")
            
            Alamofire.request(locationPath, parameters:params)
                .validate()
                .responseString { response in
                    print("Success: \(response.result.isSuccess)")
                    print(response.result.debugDescription)
                    let parsedRoutes = JSONParser().parseJSON(response.result.debugDescription)
                    for eachRoute in parsedRoutes{
                        let route = PJRouteObject.init(route: eachRoute as! [String : String])
                        self.routesArray.append(route)
                        let marker = PJLocationMarker(route: route)
                        self.markersArray.append(marker)
                        marker.map = self.mapView
                    }
                    print(self.routesArray)
                    self.updateMapWithMarkers()
            }
        }else{
            let parsedRoutes = JSONParser().parseJSON(response)
            for eachRoute in parsedRoutes{
                let route = PJRouteObject.init(route: eachRoute as! [String : String])
                self.routesArray.append(route)
                let marker = PJLocationMarker(route: route)
                self.markersArray.append(marker)
                marker.map = self.mapView
            }
            print(self.routesArray)
            updateMapWithMarkers()
        }
    }
    
    func updateMapWithMarkers(){
        path.removeAllCoordinates()
        for marker in markersArray{
            path.add(marker.position)
        }
        let bounds:GMSCoordinateBounds = GMSCoordinateBounds.init(path: path)
        let update:GMSCameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 40.0)
        mapView.moveCamera(update)
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
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("did upadte locations")
        
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            path.add(location.coordinate)
            locationManager.stopUpdatingLocation()
            
            params[Constants.Location.latKey] = String(location.coordinate.latitude)
            params[Constants.Location.lonKey] = String(location.coordinate.longitude)
        }
        
        updateMapWithMarkers()
    }
}
