//
//  SubCategoryViewModal.swift
//  IncidentReport
//
//  Created by Apple on 20/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import Foundation
import UIKit

class SubCategoryViewModal {
    
    static let share = SubCategoryViewModal()
    
    private init() {
        
    }
    
    func getSubCategory(param:[String:Any],vc:UIViewController,successClosure: @escaping (AnyObject?) -> (), failureClosure: @escaping (String?)->())  {
        APIHelper.postData(vc.view, onUrl: SubGetcategories, parameters: param as NSDictionary, successClosure: { (data) in
            if let dict = data as? [String:Any] {
                successClosure(dict as AnyObject)
            }else{
                failureClosure("data is not found")
            }
        }) { (error) in
            failureClosure("data is not found")
        }
    }
    
}
