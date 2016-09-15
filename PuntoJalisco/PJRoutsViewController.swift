//
//  PJRoutsViewController.swift
//  PuntoJalisco
//
//  Created by Félix Olivares on 9/14/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit
import Alamofire

class PJRoutsViewController: UIViewController {

    let locationPath = Constants.Paths.mainPath + Constants.Paths.locationPath
    
    var params:[String:String] = [Constants.Location.routeKey:"368", Constants.Location.latKey:"20.6716283647243", Constants.Location.lonKey:"-103.368670"]
    var parsedResponse = ""
    var routes:[PJRouteObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getLocation(){
        print("[ROUTES] - getLocation started")
        Alamofire.request(.GET, locationPath, parameters:params)
            .validate()
            .responseString { response in
                print("Success: \(response.result.isSuccess)")
                //print(response.result.debugDescription)
                let parsedRoutes = JSONParser().parseJSON(response.result.debugDescription)
                for eachRoute in parsedRoutes{
                    let route = PJRouteObject.init(route: eachRoute as! [String : String])
                    self.routes.append(route)                    
                }
                print(self.routes)
                
        }
    }
}
