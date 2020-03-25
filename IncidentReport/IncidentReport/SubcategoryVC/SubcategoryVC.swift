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
    
    @IBOutlet weak var tableViewSubCategory: UITableView!
    var categoryItem: Category.Data!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSubCategory.register(UINib(nibName: "SubcategoryCell", bundle: nil), forCellReuseIdentifier: "SubcategoryCell")
        tableViewSubCategory.tableFooterView = UIView()
        tableViewSubCategory.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        subCategoryApiCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
        self.addNavigationView(title: "Subcategory", subtitle: "Please select subcategory", image: "back", isMenu: false, isIssueForm: false)
    }
    
    func subCategoryApiCall() {
        let dict = ["Userid":AppManager.share.user.data.userID,"CategoryId":categoryItem.categoryID]
        SubCategoryViewModal.share.getSubCategory(param: dict, vc: self, successClosure: { (data) in
            if let dict = data as? [String:Any] {
                AppManager.share.subCategory = SubCategory(json: dict)
                print(AppManager.share.subCategory.data.count)
            }
            self.tableViewSubCategory.reloadData()
        }) { (error) in
            
        }
    }



}

extension SubcategoryVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let subcategory = AppManager.share.subCategory {
            print(subcategory.data.count)
            return subcategory.data.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubcategoryCell") as! SubcategoryCell
        cell.selectionStyle = .none
        cell.labelSubCategory.text = AppManager.share.subCategory.data[indexPath.row].subCategoryName
        cell.imageSubCategory.setImageWith(AppManager.share.subCategory.data[indexPath.row].icon)
        return cell
    }
    
    
}

extension SubcategoryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SubmitIssueViewController.loadFromNib()
        vc.subcategory = AppManager.share.subCategory.data[indexPath.row]
        vc.category = categoryItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
