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
        static let emailKey = "EMAIL"
        static let nameKey = "NOMBRECOMPLETO"
        static let birthDateKey = "FECHA_NAC"
        static let genderKey = "GENERO"
    }
    
    struct Location {
        static let routeKey = "RUTA"
        static let latKey = "LAT"
        static let lonKey = "LNG"
        static let hourKey = "HORA"
        static let idHardwareKey = "IDHARDWARE"
        static let dateKey = "FECHALOG"
        static let saturationKey = "SATURACION"
        static let distanceKey = "DISTANCIA"
        static let truckNumberKey = "NUMCAMION"
        static let baseKey = "base"
        static let firstRideKey = "primersalida"
        static let lastRideKey = "ultimasalida"
        static let durationKey = "duracion"
        static let routeNameKey = "nombreruta"
        static let cityKey = "ciudad"
        
    }
    
    struct Paths {
        static let mainPath = "http://192.99.41.203:99"
        static let registerPath = "/ws_REGISTRO_APP.ASPX"
        static let locationPath = "/ws_posiciones.aspx"
        static let routesPath = "/ws_rutas.aspx"
    }
    
    static let tokenKey = "token"
    static let isRegistred = "isRegistred"
}
