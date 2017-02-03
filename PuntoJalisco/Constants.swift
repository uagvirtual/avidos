//
//  Constants.swift
//  PuntoJalisco
//
//  Created by Felix on 9/9/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit

class Constants: NSObject {
    struct Register {
        static let emailKey = "email"
        static let nameKey = "nombre"
        static let birthDateKey = "fechaNac"
        static let genderKey = "genero"
    }
    
    struct Location {
        static let routeKey = "ruta"
        static let latKey = "latitud"
        static let lonKey = "longitud"
        static let hourKey = "HORA"
        static let idHardwareKey = "idHardware"
        static let dateKey = "hora"
        static let saturationKey = "saturacion"
        static let distanceKey = "distancia"
        static let truckNumberKey = "idCamion"
        static let baseKey = "base"
        static let firstRideKey = "primerSalida"
        static let lastRideKey = "ultimaSalida"
        static let durationKey = "duracion"
        static let routeNameKey = "numeroRuta"
        static let cityKey = "ciudad"
        
    }
    
    struct Paths {
        static let mainPath = "http://weon.socialideas.mx/webservices"
        static let registerPath = "/encuesta/"
        static let locationPath = "/online/"
        static let routesPath = "/rutas/"
    }
    
    static let tokenKey = "token"
    static let isRegistred = "isRegistred"
    static let isDevMode = "isDevMode"
}
