//
//  PJRoutsViewController.swift
//  PuntoJalisco
//
//  Created by Félix Olivares on 9/14/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit
import Alamofire

class PJRoutsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ViewMapButtonDelegate {

    let locationPath = Constants.Paths.mainPath + Constants.Paths.routesPath
    let cellBackgroundColor = UIColor(red: 117.0/255.0, green: 0, blue: 27.0/255.0, alpha: 1)
    
//    var params:[String:String] = [Constants.Location.routeKey:"368", Constants.Location.latKey:"20.6716283647243", Constants.Location.lonKey:"-103.368670"]
    var params:[String:String] = [Constants.Location.cityKey:"guadalajara"]
    var parsedResponse = ""
    var routesArray:[PJRouteObject] = []
    var routesFilteredArray:[String:[PJRouteObject]] = [:]
    let kRouteDetailCellIdentifier = "RouteDetailCellIdentifier"
    
    let response = "[{\"base\":\"TROMPO MÁGICO\",\"primersalida\":\"5:00\",\"ultimasalida\":\"22:30\",\"duracion\":\"3\",\"nombreruta\":\"368\",\"ciudad\":\"GUADALAJARA\"},{\"base\":\"LOPEZ MATEOS\",\"primersalida\":\"5:00\",\"ultimasalida\":\"22:30\",\"duracion\":\"3\",\"nombreruta\":\"24\",\"ciudad\":\"GUADALAJARA\"},{\"base\":\"BASILIO BADILLO (TONALÁ)\",\"primersalida\":\"5:00\",\"ultimasalida\":\"22:30\",\"duracion\":\"3\",\"nombreruta\":\"368\",\"ciudad\":\"GUADALAJARA\"},{\"base\":\"ZAPOPAN\",\"primersalida\":\"5:00\",\"ultimasalida\":\"22:30\",\"duracion\":\"3\",\"nombreruta\":\"368\",\"ciudad\":\"GUADALAJARA\"}]"
    
    
    var devMode = false
//    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView: UIExpandableTableView!
    @IBOutlet weak var loadingIndicatorContainer: UIView!
    @IBOutlet weak var activitiIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        devMode = UserDefaults.standard.bool(forKey: Constants.isDevMode)
        
        let routeCell = UINib(nibName: "PJRouteDetailTableViewCell", bundle: nil)
        tableView.register(routeCell, forCellReuseIdentifier: kRouteDetailCellIdentifier)
        tableView.separatorColor = UIColor(red: 0, green: 85.0/255.0, blue: 117.0/255.0, alpha: 1)
        tableView.tableFooterView = UIView()
        
        loadingIndicatorContainer.layer.cornerRadius = 10
        loadingIndicatorContainer.alpha = 0
        
        
        if !devMode {
            getLocation()
        }else{
            //Dev mode
            let parsedRoutes = JSONParser().parseJSON(response)
            for eachRoute in parsedRoutes{
                let route = PJRouteObject.init(route: eachRoute as! [String : String])
                self.routesArray.append(route)
            }
            print("routesArray")
            print(self.routesArray)
            
            for eachObject in self.routesArray{
                let name = eachObject.routeName!
                if let _ = routesFilteredArray[name]{
                    routesFilteredArray[name]?.append(eachObject)
                }else{
                    routesFilteredArray[name] = [eachObject]
                }
            }
            
            print("routesFiteredArray")
            print(routesFilteredArray)
            
            self.tableView.reloadData()
            self.hideActivityIndicator()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        tableView.headerViewClose(self.tableView.sectionOpen)
    }
    
    @IBAction func refreshButtonPressed(_ sender: AnyObject) {
        getLocation()
    }

    func showActivityIndicator(){
        activitiIndicator.startAnimating()
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingIndicatorContainer.alpha = 1
            }, completion: nil)
    }
    
    func hideActivityIndicator(){
        activitiIndicator.stopAnimating()
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingIndicatorContainer.alpha = 0
        }, completion: { (completed) in }) 
    }
    
    func getLocation(){
        showActivityIndicator()
        print("[ROUTES] - getLocation started")
        Alamofire.request(locationPath, parameters:params)
            .validate()
            .responseString { response in
                print("Success: \(response.result.isSuccess)")
                if response.result.isSuccess{
                    if self.routesArray.count > 0{
                        self.routesArray.removeAll()
                    }
                    
                    let parsedRoutes = JSONParser().parseJSON(response.result.debugDescription)
                    print("\(parsedRoutes)")
                    for eachRoute in parsedRoutes{
                        let route = PJRouteObject.init(route: eachRoute as! [String : String])
                        route.printDebug()
                        self.routesArray.append(route)
                    }
                    print(self.routesArray)
                    
                    for eachObject in self.routesArray{
                        let name = eachObject.routeName!
                        if let _ = self.routesFilteredArray[name]{
                            self.routesFilteredArray[name]?.append(eachObject)
                        }else{
                            self.routesFilteredArray[name] = [eachObject]
                        }
                    }
                    
                    self.tableView.reloadData()
                    self.hideActivityIndicator()
                }else{
                    self.hideActivityIndicator()
                    let alertController = UIAlertController(title: "Atención", message:"Ha ocurrido un error de conexión, por favor intentalo mas tarde.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
        }
    }
    
    func goToViewMap() {
        tabBarController?.selectedIndex = 0
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 339
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return routesFilteredArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (!routesFilteredArray.isEmpty) {
            if (self.tableView.sectionOpen != NSNotFound && section == self.tableView.sectionOpen) {
                var components = Array(routesFilteredArray.keys)
                let sectionString = components[section]
                return routesFilteredArray[sectionString]!.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var components = Array(routesFilteredArray.keys)
        let sectionString = components[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kRouteDetailCellIdentifier, for: indexPath) as! PJRouteDetailTableViewCell
        
        cell.delegate = self
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        
        cell.route = routesFilteredArray[sectionString]![indexPath.row]
        cell.titleLabel.text = routesFilteredArray[sectionString]![indexPath.row].base
        cell.baseLabel.text = routesFilteredArray[sectionString]![indexPath.row].base
        cell.firstTripLabel.text = routesFilteredArray[sectionString]![indexPath.row].firstRide
        cell.lastTripLabel.text = routesFilteredArray[sectionString]![indexPath.row].lastRide
        cell.durationLabel.text = routesFilteredArray[sectionString]![indexPath.row].duration
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(tableView: self.tableView, section: section)
        headerView.backgroundColor = UIColor(red: 117.0/255.0,
                                             green: 0/255.0,
                                             blue: 27.0/255.0,
                                             alpha: 1)
        
        var components = Array(routesFilteredArray.keys)
        let sectionString = components[section]
        
        let label = UILabel(frame: headerView.frame)
        label.text = "  Ruta \(sectionString)"
//        label.textAlignment = NSTextAlignment.Left
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor = UIColor.white
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    /*
    //MARK: Table View delegate methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:PJRouteTableViewCell = tableView.dequeueReusableCellWithIdentifier(kRouteCellIdentifier) as! PJRouteTableViewCell
        cell.routeLabel.text = "Ruta " + routesArray[indexPath.row].routeName!
        cell.accessoryType = .DisclosureIndicator
//        cell.accessoryView?.backgroundColor = UIColor.clearColor()
        cell.contentView
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        PJRouteManager.sharedInstance.setRoute(routesArray[indexPath.row])
//        PJRouteManager.sharedInstance.displayCurrentRoute()
        performSegueWithIdentifier("toRouteDetail", sender: self)
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = cellBackgroundColor
    }
    
    */
}
