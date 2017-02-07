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
    
    var base:String?
    var firstRide:String?
    var lastRide:String?
    var duration:String?
    var routeName:String?
    var city:String? 
    
    
    override init() {
        super.init()
    }
    
    init(route:[String:String]) {
        super.init()
        configure(route)
    }
    
    func configure(_ route:[String:String]){
        print(route)
        hour = route[Constants.Location.hourKey]
        id = route[Constants.Location.idHardwareKey]
        lon = route[Constants.Location.lonKey]
        routeNumber = route[Constants.Location.routeKey]
        date = route[Constants.Location.dateKey]
        saturation = route[Constants.Location.saturationKey]
        lat = route[Constants.Location.latKey]
        distance = route[Constants.Location.distanceKey]
        truckNumber = route[Constants.Location.truckNumberKey]
        
        base = route[Constants.Location.baseKey]
        firstRide = route[Constants.Location.firstRideKey]
        lastRide = route[Constants.Location.lastRideKey]
        duration = route[Constants.Location.durationKey]
        routeName = route[Constants.Location.routeNameKey]
        city = route[Constants.Location.cityKey]
        
        //return self
    }
    
    func printDebug(){
        print("\n---> [ROUTE MANAGER] Current Route\nBase: \(base)\nPrimer Salida: \(firstRide)\nUltimaSalid: \(lastRide)\nDuracion: \(duration)\nNombre: \(routeName)\nCiudad: \(city)\n----\nHora: \(hour)\nId Hardware: \(id)\nLat: \(lat)\nLon: \(lon)\nRuta: \(routeNumber)\nFecha Log: \(date)\nSaturacion: \(saturation)\nDistancia: \(distance)\nNumero de Camion: \(truckNumber)\n")
    }
}
