//
//  AppDelegate.swift
//  IncidentReport
//
//  Created by Arpita Jain on 19/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import UIKit
import SWRevealViewController
import CoreLocation
import GooglePlaces
import GoogleMaps


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var navController: UINavigationController!
    var revealVC: SWRevealViewController!
    var locationManager: CLLocationManager!
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"


     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            
            initLocationManager();
            GMSServices.provideAPIKey(googleApiKey)
            GMSPlacesClient.provideAPIKey(googleApiKey)

    //        showLoginView()
            return true
        }

        func applicationWillResignActive(_ application: UIApplication) {
            // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
            // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        }

        func applicationDidEnterBackground(_ application: UIApplication) {
            // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
            // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        }

        func applicationWillEnterForeground(_ application: UIApplication) {
            // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        }

        func applicationDidBecomeActive(_ application: UIApplication) {
            // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        }

        func applicationWillTerminate(_ application: UIApplication) {
            // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        }


        func showLoginView(){
            let UserDefaultsVal = UserDefaults()
                let LoginVal = UserDefaultsVal.object(forKey: "login") as? String
                if LoginVal == "yes" {
                    
                    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                    let mainViewController = mainStoryBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController

                    let leftMenuVC = LeftMenuVC(nibName: "LeftMenuVC", bundle:nil)
                    
                    navController = UINavigationController(rootViewController: mainViewController);
                    Common.addMenuNavigationLeftButtonOn(controller: mainViewController);
                    
                    self.revealVC = SWRevealViewController(rearViewController: leftMenuVC, frontViewController: navController);
                    self.revealVC.rearViewRevealWidth = UIScreen.main.bounds.size.width-60;
                    self.window?.rootViewController = self.revealVC;
                    
                } else {
                    
                    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    let navController = UINavigationController(rootViewController: vc);
                    navController.setNavigationBarHidden(true, animated: false)
                    self.window?.rootViewController =  navController;
                }
            
        }
        
    }


    // Location Manager helper stuff
    extension AppDelegate {
        func initLocationManager() {
            seenError = false
            locationFixAchieved = false
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            locationManager.requestAlwaysAuthorization()
        }
        
        // Location Manager Delegate stuff
        // If failed
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            
            locationManager.stopUpdatingLocation()
            if ((error) != nil) {
                if (seenError == false) {
                    seenError = true
                    print(error)
                }
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            if (locationFixAchieved == false) {
                locationFixAchieved = true
                let locationArray = locations as NSArray
                let locationObj = locationArray.lastObject as! CLLocation
                let coord = locationObj.coordinate
                
                print(coord.latitude)
                print(coord.longitude)

                AppManager.share.lat = coord.latitude
                AppManager.share.long = coord.longitude
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            var shouldIAllow = false
            
            switch status {
            case CLAuthorizationStatus.restricted:
                locationStatus = "Restricted Access to location"
            case CLAuthorizationStatus.denied:
                locationStatus = "User denied access to location"
            case CLAuthorizationStatus.notDetermined:
                locationStatus = "Status not determined"
            default:
                locationStatus = "Allowed to location Access"
                shouldIAllow = true
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LabelHasbeenUpdated"), object: nil)
            if (shouldIAllow == true) {
                NSLog("Location to Allowed")
                // Start location services
                locationManager.startUpdatingLocation()
            } else {
                NSLog("Denied access: \(locationStatus)")
            }
        }
    }
