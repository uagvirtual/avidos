//
//  PJRouteDetailViewController.swift
//  PuntoJalisco
//
//  Created by Developer on 9/16/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit

class PJRouteDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var lastLabelTrip: UILabel!
    @IBOutlet weak var firstTripLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var routeNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UIExpandableTableView!
    
    let currentTrip:PJRouteObject = PJRouteManager.sharedInstance.currentRoute
    let devMode = true
    let kRouteCellIdentifier = "RouteCellIdentifier"
    let kRouteDetailCellIdentifier = "RouteDetailCellIdentifier"
    
    var items:[[Int]?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseLabel.text = currentTrip.base!
        firstTripLabel.text = currentTrip.firstRide!
        lastLabelTrip.text = currentTrip.lastRide!
        durationLabel.text = currentTrip.duration! + " hrs"
        routeNameLabel.text = "Ruta " + currentTrip.routeName!
                
        _ = UINib(nibName: "PJRouteTableViewCell", bundle: nil)
    
        
        let routeDetailCell = UINib(nibName: "PJRouteDetailTableViewCell", bundle: nil)
        tableView.register(routeDetailCell, forCellReuseIdentifier: kRouteDetailCellIdentifier)
        
        // create data
        for i in 0 ..< Int(arc4random_uniform(100)) {
            items.append([])
            for j in 0 ..< Int(arc4random_uniform(100)) {
                items[i]!.append(j)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonPressed(_ sender: AnyObject) {
//        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewMapPressed(_ sender: AnyObject) {
        tabBarController?.selectedIndex = 0
    }
    
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 339
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (!items.isEmpty) {
            if (self.tableView.sectionOpen != NSNotFound && section == self.tableView.sectionOpen) {
                return items[section]!.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kRouteDetailCellIdentifier, for: indexPath)
//        cell.textLabel?.text = "section \(indexPath.section) row \(indexPath.row)"
//        cell.textLabel?.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(tableView: self.tableView, section: section)
        headerView.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(100)) / 100.0,
                                             green: CGFloat(arc4random_uniform(100)) / 100.0,
                                             blue: CGFloat(arc4random_uniform(255)) / 100.0,
                                             alpha: 1)
        
        let label = UILabel(frame: headerView.frame)
        label.text = "Section \(section), touch here!"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = UIColor.white
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
