//
//  LoginViewController.swift
//  IncidentReport
//
//  Created by Apple on 20/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import UIKit
import SwAlert

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: DesignableUITextField!
    @IBOutlet weak var passwordTextField: DesignableUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func validationForLogin() -> Bool{
        var error = ""
        
        if emailTextField.text == "" {
            error = "Please enter email"
        } else if passwordTextField.text == "" {
            error = "Please enter password"
        }
        if error != "" {
            SwAlert.showAlert("Incident Report", message: error, buttonTitle: "OK")
            return false
        } else {
            return true
        }
    }

    @IBAction func btnLoginAction(sender:UIButton) {
        if validationForLogin(){
            Common.setUserDefault(obj: "yes" as AnyObject, forKey: "login")
                APPDELEGATE.showLoginView()
//            let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//            if #available(iOS 13.0, *) {
//                let vc = storyboardMain.instantiateViewController(withIdentifier: "MapViewController")
//                self.navigationController?.pushViewController(vc, animated: true)
//            } else {
//                // Fallback on earlier versions
//                let vc = storyboardMain.instantiateViewController(withIdentifier: "MapViewController")
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
        }
    }

}
