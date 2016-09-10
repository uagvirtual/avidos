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
    
    struct Paths {
        static let mainPath = "http://192.99.41.203:99"
        static let registerPath = "/ws_REGISTRO_APP.ASPX"
    }
    
    static let tokenKey = "token"
    static let isRegistred = "isRegistred"
}
