//
//  PJRouteManager.swift
//  PuntoJalisco
//
//  Created by Developer on 9/16/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit

class PJRouteManager {
    static let sharedInstance = PJRouteManager()
    
    var currentRoute:PJRouteObject!
    
    fileprivate init() {
        print(#function)
        currentRoute = PJRouteObject()
    }
    
    func setRoute(_ route:PJRouteObject){
        // Set Route object
        currentRoute.hour = route.hour
        currentRoute.id = route.id
        currentRoute.lon = route.lon
        currentRoute.routeNumber = route.routeNumber
        currentRoute.date = route.date
        currentRoute.saturation = route.saturation
        currentRoute.lat = route.lat
        currentRoute.distance = route.distance
        currentRoute.truckNumber = route.truckNumber
        
        currentRoute.base = route.base
        currentRoute.firstRide = route.firstRide
        currentRoute.lastRide = route.lastRide
        currentRoute.duration = route.duration
        currentRoute.routeName = route.routeName
        currentRoute.city = route.city
    }
    
    func displayCurrentRoute(){
        print("\n---> [ROUTE MANAGER] Current Route\nBase: \(currentRoute.base)\nPrimer Salida: \(currentRoute.firstRide)\nUltimaSalid: \(currentRoute.lastRide)\nDuracion: \(currentRoute.duration)\nNombre: \(currentRoute.routeName)\nCiudad: \(currentRoute.city)\n----\nHora: \(currentRoute.hour)\nId Hardware: \(currentRoute.id)\nLat: \(currentRoute.lat)\nLon: \(currentRoute.lon)\nRuta: \(currentRoute.routeNumber)\nFecha Log: \(currentRoute.date)\nSaturacion: \(currentRoute.saturation)\nDistancia: \(currentRoute.distance)\nNumero de Camion: \(currentRoute.truckNumber)\n")
    }
        
}
