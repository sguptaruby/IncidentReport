//
//  CategoryVC.swift
//  IncidentReport
//
//  Created by Arpita Jain on 19/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryTableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        categoryTableView.tableFooterView = UIView()
        categoryTableView.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
    }

}

extension CategoryVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppManager.share.category.data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        cell.selectionStyle = .none
        cell.categoryLabel.text = AppManager.share.category.data[indexPath.row].categoryName        
        cell.categoryImage.setImageWith(AppManager.share.category.data[indexPath.row].icon)
        
        return cell
        
    }
}

extension CategoryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SubcategoryVC.loadFromNib()
        vc.categoryItem = AppManager.share.category.data[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
