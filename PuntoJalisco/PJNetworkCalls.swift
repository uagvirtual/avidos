//
//  PJNetworkCalls.swift
//  PuntoJalisco
//
//  Created by Felix on 9/9/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit
import Alamofire

class PJNetworkCalls: NSObject {
    
    override init() {
        super.init()
    }
    
    func registerUser() -> Bool{
        print("register user called")
        let params:[String:String] = [Constants.Register.birthDateArg:"1965-01-01", Constants.Register.genderArg:"M", Constants.Register.nameArg:"Felix"]
        let path = Constants.Paths.mainPath + Constants.Paths.registerPath
        
        Alamofire.request(.GET, path, parameters:params)
            .validate()
            .responseString { response in
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(response.request!)")
        }
        return true
    }

}
