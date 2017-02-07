//
//  JSONParser.swift
//  PuntoJalisco
//
//  Created by Félix Olivares on 9/15/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit

class JSONParser: NSObject {
    
    func parseJSON(_ response:String) -> NSArray{
        let needleEnd:Character = "]"
        let needleStart:Character = "["
        var posEnd = 0
        var posStart = 0
        if let indexEnd = response.characters.index(of: needleEnd){
            posEnd = response.characters.distance(from: response.startIndex, to: indexEnd)
        }
        
        if let indexStart = response.characters.index(of: needleStart){
            posStart = response.characters.distance(from: response.startIndex, to: indexStart)
        }
        
        let range = response.characters.index(response.startIndex, offsetBy: posStart)..<response.characters.index(response.startIndex, offsetBy: posEnd+1)
        let parsedResponse = response.substring(with: range)        
        let data = parsedResponse.data(using: String.Encoding.utf8)
        var json = NSArray()
        do{
            json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray 
        }catch {
            print("error serializing JSON: \(error)")
        }
        return json as NSArray
    }
}
