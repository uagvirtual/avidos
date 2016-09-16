//
//  PJRoutsViewController.swift
//  PuntoJalisco
//
//  Created by Félix Olivares on 9/14/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit
import Alamofire

class PJRoutsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let locationPath = Constants.Paths.mainPath + Constants.Paths.locationPath
    let cellBackgroundColor = UIColor(red: 117.0/255.0, green: 0, blue: 27.0/255.0, alpha: 1)
    
    var params:[String:String] = [Constants.Location.routeKey:"368", Constants.Location.latKey:"20.6716283647243", Constants.Location.lonKey:"-103.368670"]
    var parsedResponse = ""
    var routesArray:[PJRouteObject] = []
    let kRouteCellIdentifier = "RouteCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getLocation()
        
        let routeCell = UINib(nibName: "PJRouteTableViewCell", bundle: nil)
        tableView.registerNib(routeCell, forCellReuseIdentifier: kRouteCellIdentifier)
        
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
                    self.routesArray.append(route)
                }
                print(self.routesArray)
                self.tableView.reloadData()
                
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:PJRouteTableViewCell = tableView.dequeueReusableCellWithIdentifier(kRouteCellIdentifier) as! PJRouteTableViewCell
        cell.routeLabel.text = "Ruta " + routesArray[indexPath.row].routeNumber!
        cell.accessoryType = .DisclosureIndicator
//        cell.accessoryView?.backgroundColor = UIColor.clearColor()
        cell.contentView
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = cellBackgroundColor
    }
}
