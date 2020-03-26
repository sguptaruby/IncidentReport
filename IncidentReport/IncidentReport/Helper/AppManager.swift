//
//  AppManager.swift
//  IncidentReport
//
//  Created by Macmini3 on 19/03/20.
//  Copyright © 2020 Macmini. All rights reserved.
//

import Foundation
import UIKit

class AppManager {
    
 static let share = AppManager()
    
  private init() {
        
    }
    
    lazy var strAddress = ""
    var lat: Double! 
    var long: Double!
    var user:User!
    var category:Category!
    var subCategory: SubCategory!
    var arrImages = [UIImage]()
    var IncidentImageCount:String!
    var naviView: NavigationView!
    var issue: IssueList!
}
