//
//  PJLocationMarker.swift
//  PuntoJalisco
//
//  Created by Developer on 9/26/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit

class PJLocationMarker: GMSMarker {
    let route:PJRouteObject!
    
    init(route:PJRouteObject) {
        self.route = route
        super.init()
        
        print("Latitude: \((route.lat! as NSString).doubleValue) - Longitude: \((route.lon! as NSString).doubleValue)")
        position = CLLocationCoordinate2DMake((route.lat! as NSString).doubleValue, (route.lon! as NSString).doubleValue)
        switch route.saturation! {
        case "G":
            icon = UIImage(named: "greenBus")
        case "Y":
            icon = UIImage(named: "orangeBus")
        case "R":
            icon = UIImage(named: "redBus")
        default:
            icon = UIImage(named: "greenBus")
        }
        groundAnchor = CGPoint(x: 0, y: 0)
        appearAnimation = kGMSMarkerAnimationPop
    }
}
