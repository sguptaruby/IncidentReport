//
//  CategoryVC.swift
//  IncidentReport
//
//  Created by Arpita Jain on 19/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
var arrMenu = [String]()
    @IBOutlet weak var categoryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryTableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        categoryTableView.tableFooterView = UIView()
        categoryTableView.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CategoryVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        cell.textLabel?.text = arrMenu[indexPath.row]
        return cell
    }
}
