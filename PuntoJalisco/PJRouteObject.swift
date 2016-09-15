//
//  PJRouteObject.swift
//  PuntoJalisco
//
//  Created by Félix Olivares on 9/15/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit

class PJRouteObject: NSObject {
    
    var hour:String?
    var id:String?
    var lon:String?
    var routeNumber:String?
    var date:String?
    var saturation:String?
    var lat:String?
    var distance:String?
    var truckNumber:String?
    
    override init() {
        super.init()
    }
    
    init(route:[String:String]) {
        super.init()
        configure(route)
    }
    
    func configure(route:[String:String]) -> PJRouteObject{
        print(route)
        hour = route[Constants.Location.hourKey]
        id = route[Constants.Location.id]
        lon = route[Constants.Location.lonKey]
        routeNumber = route[Constants.Location.routeKey]
        date = route[Constants.Location.date]
        saturation = route[Constants.Location.saturation]
        lat = route[Constants.Location.latKey]
        distance = route[Constants.Location.distance]
        truckNumber = route[Constants.Location.truckNumber]
        return self
    }
    
    func printDebug(){
        print("Hora: \(hour!)\nId Hardware: \(id!)\nLat: \(lat!)\nLon: \(lon!)\nRuta: \(routeNumber!)\nFecha Log: \(date!)\nSaturacion: \(saturation!)\nDistancia: \(distance!)\nNumero de Camion: \(truckNumber!)\n")
    }
}
