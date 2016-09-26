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
        
        position = CLLocationCoordinate2DMake((route.lat! as NSString).doubleValue, (route.lon! as NSString).doubleValue)
        icon = UIImage(named: "greenBus")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
    }
}
