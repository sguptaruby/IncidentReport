//
//  ControllerExtension.swift
//  IncidentReport
//
//  Created by Apple on 20/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    internal func showHUD() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }

    internal func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: false)
    }
}
