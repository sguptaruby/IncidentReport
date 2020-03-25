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
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    func addNavigationView(title:String,subtitle:String,image:String,isMenu:Bool,isIssueForm:Bool) {
        AppManager.share.naviView = (NavigationView().loadNib() as! NavigationView)
        AppManager.share.naviView.frame = CGRect(x: 0, y: 10, width: self.view.frame.width, height: 100)
        AppManager.share.naviView.lblTitle.text = title
        AppManager.share.naviView.lblAddress.text = subtitle
        AppManager.share.naviView.btnMenu.setImage(UIImage(named: image), for: .normal)
        
        if isMenu {
            AppManager.share.naviView.widthImageView.constant = 15.0
            AppManager.share.naviView.btnMenu.addTarget(self, action: #selector(openMenu(sender:)), for: .touchUpInside)
        }else{
            AppManager.share.naviView.widthImageView.constant = 0.0
            AppManager.share.naviView.btnMenu.addTarget(self, action: #selector(navigationBack), for: .touchUpInside)
        }
        if isIssueForm {
            AppManager.share.naviView.widthImageView.constant = 15.0
        }
        self.view.addSubview(AppManager.share.naviView)
    }
    
    @objc func openMenu(sender:UIButton) {
        
    }
    
    @objc func navigationBack(sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func hideNavigationBar(){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func showNavigationBar() {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
}

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}

extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
