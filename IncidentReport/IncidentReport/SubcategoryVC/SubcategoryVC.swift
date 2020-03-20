//
//  SubcategoryVC.swift
//  IncidentReport
//
//  Created by Arpita Jain on 20/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import UIKit
import SwAlert

class SubcategoryVC: UIViewController {
    
    var categoryItem: Category.Data!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        subCategoryApiCall()
    }
    
    func subCategoryApiCall() {
        let dict = ["Userid":AppManager.share.user.data.userID,"CategoryId":categoryItem.categoryID]
        SubCategoryViewModal.share.getSubCategory(param: dict, vc: self, successClosure: { (data) in
            if let dict = data as? [String:Any] {
                AppManager.share.subCategory = SubCategory(json: dict)
            }
        }) { (error) in
            
        }
    }



}
