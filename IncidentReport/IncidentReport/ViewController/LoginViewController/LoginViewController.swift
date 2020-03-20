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
        getAddressApiCall()
        emailTextField.text = "sumit.thalwal@kmgin.com"
        passwordTextField.text = "kmg125"
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
            loginApiCall(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
    func loginApiCall(email:String,password:String) {
        let dict = [
            "UserName":email,
            "Password":password,
            "Location":AppManager.share.strAddress,
            "Latitude":AppManager.share.lat,
            "Longitude":AppManager.share.long,
            "Address":"",
            "DeviceType":"Ios",
            "DeviceToken":"spectral"
            ] as [String : Any]
        LoginViewModal.share.login(param: dict, vc: self, successClosure: { (data) in
            if let dict = data as? [String:Any] {
                AppManager.share.user = User(json: dict)
                Common.saveDict(dict: dict as NSDictionary, key: "user")
                Common.setUserDefault(obj: "yes" as AnyObject, forKey: "login")
                APPDELEGATE.showLoginView()
            }
        }) { (error) in
            SwAlert.showAlert("Incident Report", message: error, buttonTitle: "OK")
        }
    }
    
    func getAddressApiCall() {
        MapViewModal.share.getFullAddress(lat: AppManager.share.lat, long: AppManager.share.long, vc: self, successClosure: { (data) in
            if let dict = data {
                let address = Address(json: dict as! [String : Any])
                AppManager.share.strAddress = address?.results.first?.formattedAddress ?? ""
            }
        }) { (error) in
            print(error)
        }
    }

}
