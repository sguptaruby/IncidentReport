//
//  Common.swift
//  HitchApp
//
//  Created by roy on 4/23/19.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

var K_APP_deviceID: String {
    return Common.getUserDefault(forKey: "deviceID") as! String
}
var K_APP_deviceToken: String {
    return Common.getUserDefault(forKey: "deviceToken") as! String
}

class Common: NSObject {
    
    class func setUserDefault(obj: AnyObject!, forKey key: String!) {
        UserDefaults.standard.set(obj as Any, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getUserDefault(forKey key: String!) -> AnyObject? {
        return  UserDefaults.standard.value(forKey: key) as AnyObject?
    }
    
    
    class func saveDict(dict: NSDictionary, key: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: dict)
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey:key)
    }
    
    
    class func getDict(key: String) -> NSDictionary? {
        if let data = UserDefaults.standard.object(forKey: key) as? NSData {
            let object = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! NSDictionary
            return object;
        }
        return nil
    }
    
    
    
    class func addMenuNavigationLeftButtonOn(controller: UIViewController)
    {
        let btnMenu: UIButton! = UIButton(frame: CGRect( x:0, y:0, width:30, height:30));
        btnMenu .setImage(UIImage(named: "_0024_Menu_Icon"), for: UIControl.State.normal);
        btnMenu.addTarget(Common.self, action: #selector(Common.showLeftMenu), for: UIControl.Event.touchUpInside);
        
        let barBtnMenu: UIBarButtonItem! = UIBarButtonItem(customView: btnMenu);
        controller.navigationItem.leftBarButtonItem = barBtnMenu;
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        controller.navigationController?.navigationBar.barTintColor = UIColor.white
        controller.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        
    }
    @objc class func showLeftMenu()
    {
        
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);

        let newUser = Common.getBool(object: Common.getUserDefault(forKey: "newUser"), else: false)
        if newUser != true  {
            
        }
    }
    
    class func getBool(object: AnyObject?, else returnValue: Bool!) -> Bool {
        
        if object is NSNull { return returnValue }
        if let obj = object {  return (obj as AnyObject).boolValue  }
        else { return returnValue }
    }
    
    class func getInt(object: AnyObject?, else returnValue: Int!) -> Int {
        
        // print("Object is: ", object);
        
        if object is NSNull {
            return returnValue
        }
        if let obj = object {
            return (obj as AnyObject).intValue
        }
        else {
            return returnValue
        }
    }
    
    class func getUInt(object: AnyObject?, else returnValue: UInt!) -> UInt {
        
        // print("Object is: ", object);
        
        if object is NSNull {
            return returnValue
        }
        if let obj = object {
            return (obj as AnyObject).uintValue
        }
        else {
            return returnValue
        }
    }
    
    class func getFloat(object: AnyObject?, else returnValue: Float!) -> Float {
        
        if object is NSNull { return returnValue }
        if let obj = object {  return (obj as AnyObject).floatValue  }
        else { return returnValue }
    }
    
    class func getObject(object: AnyObject?, else returnValue: AnyObject!) -> AnyObject? {
        
        // print("Object is: ", object);
        
        if object is NSNull {
            return returnValue
        }
        if let obj = object {
            return obj
        }
        else {
            return returnValue
        }
    }
    
    
    class func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(XXX)XXX-XXXX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        print(result)
        return result
    }
}

//MARK: - UIView

extension UIView{
    func reloadViewContentAnimated() {
        
        let transitionFade = CATransition()
        transitionFade.type = CATransitionType.fade
        transitionFade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transitionFade.fillMode = CAMediaTimingFillMode.both
        transitionFade.duration = 0.25
        transitionFade.subtype = CATransitionSubtype.fromTop
        
        self.layer.add(transitionFade, forKey: "UITableViewReloadDataAnimationKey")
    }}
//MARK: - UIColor

extension UIColor {
    
    /// This methods takes input string with # attached to it, and can process 6 or 8 digit code
    ///
    /// - Parameter hexString: 6 or 8 digit code with #
    
    public convenience init(color255R R: Int, G: Int, B: Int, A: Float) {
        self.init(red: CGFloat(R)/255.0, green: CGFloat(G)/255.0, blue: CGFloat(B)/255.0, alpha: CGFloat(A))
    }
    
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])//hexString.substring(from: start)
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
            else if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255
                    a = 1.0
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}

extension String {
    func toBase64()->String{
        
        let data = self.data(using: String.Encoding.utf8)
        
        return data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
    }
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    
}

func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}
func isValidMobile(testStr:String) -> Bool {
    let mobileRegEx = "^[1{1}]\\s\\d{3}-\\d{3}-\\d{4}$"
    let mobileTest = NSPredicate(format:"SELF MATCHES %@", mobileRegEx)
    return mobileTest.evaluate(with: testStr)
}


func convertImageToBase64(image: UIImage) -> String {
    let strBase64 = image.jpegData(compressionQuality: 1.0)!.base64EncodedString()
    return strBase64
}

//
// Convert a base64 representation to a UIImage
//
func convertBase64ToImage(imageString: String) -> UIImage {
    let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
    return UIImage(data: imageData)!
}

extension UIView {
    ///  - Show loading View with  a view
    func showLoading(position: CGPoint, disableUserInteractionOn view: UIView) {
        
        let view1 = UIView(frame:CGRect(x: 0, y: 0, width: 80, height: 80))
        view1.center = position
        view1.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        view1.layer.cornerRadius = 5.0
        view1.tag = 1001
        self.addSubview(view1)
        
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.tintColor = UIColor.darkGray
        activityView.center = CGPoint(x: view1.frame.size.width  / 2,
                                      y: view1.frame.size.height / 2)
        activityView.startAnimating()
        view1.addSubview(activityView)
        
        view.isUserInteractionEnabled = false
    }
    
    func removeLoading(enableUserInteractionOn view: UIView) {
        OperationQueue.main.addOperation {
            
            for viewTemp in self.subviews {
                if viewTemp.tag == 1001 {
                    viewTemp.removeFromSuperview()
                }
                if viewTemp is UIActivityIndicatorView {
                    (viewTemp as! UIActivityIndicatorView).stopAnimating()
                    (viewTemp as! UIActivityIndicatorView).removeFromSuperview()
                }
            }
            
            view.isUserInteractionEnabled = true
        }
    }
    
    func addBackgroundLabel(tableView: UITableView, text: String){
        let label = UILabel(frame: CGRect(x:10, y:20, width:self.bounds.size.width-20, height:70))
        label.textAlignment = .center
        label.text = text
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "SFUITEXT-REGULAR", size: 17.0)
        tableView.backgroundView = label
    }
}

