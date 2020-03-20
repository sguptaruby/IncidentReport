//
//  MapViewModal.swift
//  IncidentReport
//
//  Created by Macmini3 on 19/03/20.
//  Copyright © 2020 Macmini. All rights reserved.
//

import Foundation
import UIKit

class MapViewModal {
    
    static let share = MapViewModal()
    
    private init() {
        
    }
    
    func getFullAddress(lat:Double,long:Double,vc:UIViewController,successClosure: @escaping (AnyObject?) -> (), failureClosure: @escaping (String?)->()) {
        let strUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(long)&key=\(googleApiKey)"
        var request = URLRequest(url: URL(string: strUrl)!)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
          print(response!)
            do {
                if let json = try JSONSerialization.jsonObject(with: data!) as? Dictionary<String, AnyObject> {
                    print(json)
                    successClosure(json as AnyObject)
                }
                
            } catch {
                print("error")
                failureClosure("Address not found.")
            }
        }).resume()
        
    }
    
    
    
}
