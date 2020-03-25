//
//  Constants.swift
//  HitchApp
//
//  Created by roy on 5/20/19.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

let kappName = "Incident Report"

let googleApiKey = "AIzaSyDPCFuocmjodADPmnWhM1ODSBYkAWWdS2o"
let keyData     = "12345678901234561234567890123456".data(using:String.Encoding.utf8)!
let ivData      = "abcdefghijklmnop".data(using:String.Encoding.utf8)!


let Production = "http://del.kmgin.com:9020/IncidentReporting/api/"



let AuthenticateUser = Production+"Users/AuthenticateUser"
let Getcategories = Production+"categories/Getcategories"
let SubGetcategories = Production+"Categories/GetSubCategories"
let GetParameterData = Production+"Parameters/GetParameterData"
let GetIssueList = Production+"Incident/GetPendingIssues"
let AddIncidentRequest = Production+"Incident/AddIncidentRequest"
let AddImage = Production+"Incident/AddImage"





