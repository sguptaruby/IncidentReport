//
//  LoginViewModal.swift
//  IncidentReport
//
//  Created by Apple on 20/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import Foundation
import UIKit

class LoginViewModal {
    
    
    static let share = LoginViewModal()
    
    private init() {
        
    }
    
    func login(param:[String:Any],vc:UIViewController,successClosure: @escaping (AnyObject?) -> (), failureClosure: @escaping (String?)->())  {
        vc.showHUD()
        APIHelper.postData(vc.view, onUrl: AuthenticateUser, parameters: param as NSDictionary, successClosure: { (data) in
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
