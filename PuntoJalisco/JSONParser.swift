//
//  JSONParser.swift
//  PuntoJalisco
//
//  Created by Félix Olivares on 9/15/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit

class JSONParser: NSObject {
    
    func parseJSON(response:String) -> NSArray{
        let needleEnd:Character = "]"
        let needleStart:Character = "["
        var posEnd = 0
        var posStart = 0
        if let indexEnd = response.characters.indexOf(needleEnd){
            posEnd = response.startIndex.distanceTo(indexEnd)
        }
        
        if let indexStart = response.characters.indexOf(needleStart){
            posStart = response.startIndex.distanceTo(indexStart)
        }
        
        let range = response.startIndex.advancedBy(posStart)..<response.startIndex.advancedBy(posEnd+1)
        let parsedResponse = response.substringWithRange(range)        
        let data = parsedResponse.dataUsingEncoding(NSUTF8StringEncoding)
        var json:AnyObject = []
        do{
            json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
        }catch {
            print("error serializing JSON: \(error)")
        }
        return json as! NSArray
    }
}
