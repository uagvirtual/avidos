//
//  PJRouteDetailViewController.swift
//  PuntoJalisco
//
//  Created by Developer on 9/16/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit

class PJRouteDetailViewController: UIViewController {

    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var lastLabelTrip: UILabel!
    @IBOutlet weak var firstTripLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var routeNameLabel: UILabel!
    
    let currentTrip:PJRouteObject = PJRouteManager.sharedInstance.currentRoute
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseLabel.text = currentTrip.base!
        firstTripLabel.text = currentTrip.firstRide!
        lastLabelTrip.text = currentTrip.lastRide!
        durationLabel.text = currentTrip.duration! + " hrs"
        routeNameLabel.text = "Ruta " + currentTrip.routeName!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
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
