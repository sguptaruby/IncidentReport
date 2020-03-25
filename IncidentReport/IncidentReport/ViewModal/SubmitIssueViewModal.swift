//
//  SubmitIssueViewModal.swift
//  IncidentReport
//
//  Created by Apple on 24/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import Foundation
import UIKit

class SubmitIssueViewModal {
    
    static var share = SubmitIssueViewModal()
    
    private init() {
        
    }
    
    func addIncidentRequest(param:[String:Any],vc:UIViewController,successClosure: @escaping (AnyObject?) -> (), failureClosure: @escaping (String?)->())  {
           vc.showHUD()
           APIHelper.postData(vc.view, onUrl: AddIncidentRequest, parameters: param as NSDictionary, successClosure: { (data) in
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
    
    func addImage(param:[String:Any],vc:UIViewController,successClosure: @escaping (AnyObject?) -> (), failureClosure: @escaping (String?)->())  {
        vc.showHUD()
        APIHelper.postData(vc.view, onUrl: AddImage, parameters: param as NSDictionary, successClosure: { (data) in
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
