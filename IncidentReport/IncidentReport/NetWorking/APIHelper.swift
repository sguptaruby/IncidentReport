//
//  APIHelper.swift
//  SellersParadise
//
//  Created by vinay kumar on 16/03/16.
//  Copyright © 2016 Vinay. All rights reserved.
//

import UIKit
import AFNetworking


enum ApiType {
    case get, post
}

class APIHelper: NSObject {
    
    class func getVal(param:Any!) -> Any {
        
        if (param == nil) || (param is NSNull) {
            return "" as Any
        }
        else
        {
            return param
        }
    }
    
    
    class func postData(_ view: UIView, onUrl: String, parameters: NSDictionary,  successClosure: @escaping (AnyObject?) -> (), failureClosure: @escaping (String?)->()){
        
        
        if Reachability.isConnectedToNetwork(){
            let request = AFJSONRequestSerializer()
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if let authToken = Common.getUserDefault(forKey: "Authtoken") {
                request.setValue((authToken as! String), forHTTPHeaderField: "Token")
                print("token:    \(authToken )")
            }
            let manager = AFHTTPSessionManager()
            
            manager.requestSerializer = request
            let parameterDict = parameters.mutableCopy() as! NSMutableDictionary
            
            print("URL String: ", onUrl);
//            parameterDict.setValue("iPhone", forKey: "deviceType")
            
            
            print("Parameters Sent: ", parameterDict)
            manager.post(onUrl, parameters: parameterDict, progress: nil, success: {
                (operation, responseObject) in
            
                if let responseDict = responseObject as? NSDictionary {
                    print(responseDict)
                    successClosure(responseDict)
//                    let statusCode = (responseDict["statusCode"]) as! String
//                    if statusCode == "200 OK" {
//                        let result = responseDict["result"] as! NSArray
//                        successClosure(result[0] as AnyObject)
//                    }
                }else{
                    print("No Data")
                }
            }) { (operation, error) in
                failureClosure(error.localizedDescription)
             
                print("Error: " + error.localizedDescription)
            }
            
        }else{
            view.removeLoading(enableUserInteractionOn: view)
            failureClosure("Your device is currently not connected to the internet, Please check your internet connectivity and try again")
            
        }
        
        
    }
   
    
    class func postImagesWithData(_ onUrl: String, parameters: NSDictionary, withImageKey imageKey: String, withImage image: UIImage, successClosure: @escaping (AnyObject?) -> (),  failureClosure: @escaping (String?)->())
    {
        
        print("URL String: ", onUrl);
        print("Parameters Sent: ", parameters)

        let sessionConfiguration = URLSessionConfiguration.default
        let manager = AFURLSessionManager(sessionConfiguration: sessionConfiguration)
        
        var error1: NSError?
        
        
        let request = AFHTTPRequestSerializer().multipartFormRequest(withMethod: "POST", urlString: onUrl, parameters: parameters as? [String : Any], constructingBodyWith: { (formData: AFMultipartFormData) in
            
            formData.appendPart(withFileData: image.pngData()!, name: "IMAGE", fileName: imageKey, mimeType: "image/*")
        }, error: &error1)
        
        manager.uploadTask(with: request as URLRequest, from: nil, progress: { (progress: Progress) in
            
        }) { (urlResponse: URLResponse, data: Any?, error: Error?) in
            
            
            //    Common.hideHUD()
            
            print("response: ", data)
            print("Error: ", error)
            
            if(error != nil)
            {
                if((data != nil)) {
                    if(data is NSDictionary) {
                        failureClosure((data as! NSDictionary).object(forKey: "message") as? String);
                    }
                }
            }
            else
            {
                let dictData = data as! NSDictionary
                
                if(Common.getBool(object: (dictData.object(forKey: "success")! as AnyObject), else: false) == true) {
                    successClosure(dictData)
                } else {
                    failureClosure((data as! NSDictionary).object(forKey: "message") as? String)
                }
            }
            
            }.resume()
    }
    
}





import SystemConfiguration

public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}
