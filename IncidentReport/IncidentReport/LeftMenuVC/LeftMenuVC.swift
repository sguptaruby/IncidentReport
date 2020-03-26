//
//  LeftMenuVC.swift
//  slideMenuDemo
//
//  Created by roy on 1/3/19.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit
import SwAlert

let APPDELEGATE: AppDelegate = UIApplication.shared.delegate as! AppDelegate

class LeftMenuVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var arrMenu = ["View issues", "Add issue", "Logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
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



extension LeftMenuVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        cell.selectionStyle = .none
        cell.textLabel?.text = arrMenu[indexPath.row]
        return cell
    }
}

extension LeftMenuVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var controller: UIViewController!
        
        if indexPath.row == 0 {
            controller = IssueListVC(nibName: "IssueListVC", bundle: nil)
        } else if indexPath.row == 1 {
            controller = CategoryVC(nibName: "CategoryVC", bundle: nil)
        } else {
            let alert = SwAlert(title: kappName, message: "")
            alert.addAction("No")
            alert.addAction("yes") { (result) in
                Common.setUserDefault(obj: "no" as AnyObject, forKey: "login")
                APPDELEGATE.showLoginView()
                
                
            }
            alert.show()
            return
        }
        
        APPDELEGATE.navController.viewControllers = [controller]
        Common.addMenuNavigationLeftButtonOn(controller: controller);
        APPDELEGATE.revealVC.rightRevealToggle(animated: true)
        
    }
}
