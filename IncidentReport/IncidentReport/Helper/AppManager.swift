//
//  AppManager.swift
//  IncidentReport
//
//  Created by Macmini3 on 19/03/20.
//  Copyright © 2020 Macmini. All rights reserved.
//

import Foundation

class AppManager {
    
 static let share = AppManager()
    
  private init() {
        
    }
    
    lazy var strAddress = ""
    var lat: Double = 0.0
    var long: Double = 0.0
    var user:User!
    var category:Category!
    
    
    
}
