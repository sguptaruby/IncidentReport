//
//  IssueListModel.swift
//  IncidentReport
//
//  Created by Arpita Jain on 23/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//


import Foundation
import UIKit

class IssueListModel {
    
    static let share = IssueListModel()
    
    private init() {
        
    }
    
    func getIssueList(param:[String:Any],vc:UIViewController,successClosure: @escaping (AnyObject?) -> (), failureClosure: @escaping (String?)->())  {
        vc.showHUD()
        APIHelper.postData(vc.view, onUrl: GetIssueList, parameters: param as NSDictionary, successClosure: { (data) in
            vc.hideHUD()
            if let dict = data as? [String:Any] {
                successClosure(dict as AnyObject)
            }else{
                failureClosure("data is not found")
            }
        }) { (error) in
            vc.hideHUD()
            failureClosure("data is not found")
        }
    }
    
}
