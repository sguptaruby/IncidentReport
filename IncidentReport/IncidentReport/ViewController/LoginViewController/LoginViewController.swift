//
//  LoginViewController.swift
//  IncidentReport
//
//  Created by Apple on 20/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnLoginAction(sender:UIButton) {
        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            let vc = storyboardMain.instantiateViewController(identifier: "MapViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = storyboardMain.instantiateViewController(withIdentifier: "MapViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }

}
