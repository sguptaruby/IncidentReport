//
//  LeftMenuVC.swift
//  slideMenuDemo
//
//  Created by roy on 1/3/19.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit
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

extension LeftMenuVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            let surveyListViewController = self.storyboard?.instantiateViewController(withIdentifier: "SurveyListViewController") as! SurveyListViewController
//            appDelegate.slideMenuController.changeMainViewController(surveyListViewController, close: true)
//
////            self.navigationController?.pushViewController(surveyListViewController, animated: true)
//        }
//        else if indexPath.row == 1 {
//            let sosViewController = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
//            self.navigationController?.pushViewController(sosViewController, animated: true)
//        }
//        else if indexPath.row == 2 {
//            let userProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
//            self.navigationController?.pushViewController(userProfileViewController, animated: true)
//        } else {
//            let alert = UIAlertController(title: "Alert", message: kLogout, preferredStyle: .alert
//            )
//            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
//            {
//                UIAlertAction in
//
//                for controller in self.navigationController!.viewControllers as Array {
//                    if controller.isKind(of: LoginViewController.self) {
//                        self.navigationController!.popToViewController(controller, animated: true)
//                        break
//                    }
//                }
//            }
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//                UIAlertAction in
//            }
//            alert.addAction(okAction)
//            alert.addAction(cancelAction)
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
}

extension LeftMenuVC : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        cell.textLabel?.text = arrMenu[indexPath.row]
        return cell
    }
}


