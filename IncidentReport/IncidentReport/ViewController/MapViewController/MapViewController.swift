//
//  MapViewController.swift
//  IncidentReport
//
//  Created by Macmini3 on 19/03/20.
//  Copyright © 2020 Macmini. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import SwAlert

class MapViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnViewIssue: UIButton!
    @IBOutlet weak var btnAddIssue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadMapView()
        categoryApiCall()
        getParameterDataApiCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
        self.addNavigationView(title: "Location Map", subtitle: AppManager.share.strAddress, image: "menu", isMenu: true, isIssueForm: false)
    }
    
    func loadMapView() {
        
        mapView.isMyLocationEnabled = true
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
    }
    
    func addmark(lat:Double,long:Double) {
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        iconView.layer.cornerRadius = iconView.frame.height/2
        iconView.layer.masksToBounds = true
        iconView.backgroundColor = UIColor(red: 27.0/255, green: 178.0/255, blue: 187.0/255, alpha: 0.2)
        let imageview = UIImageView(frame: CGRect(x: (iconView.frame.width-30)/2, y: (iconView.frame.height-30)/2, width: 30, height: 30))
        imageview.image = UIImage(named: "indicator")
        imageview.contentMode = .scaleAspectFit
        iconView.addSubview(imageview)
        marker.iconView = iconView
        marker.title = ""
        marker.snippet = ""
        marker.map = mapView
    }
    
    func getAddressApiCall() {
        MapViewModal.share.getFullAddress(lat: AppManager.share.lat, long: AppManager.share.long, vc: self, successClosure: { (data) in
            if let dict = data {
                let address = Address(json: dict as! [String : Any])
                AppManager.share.strAddress = address?.results.first?.formattedAddress ?? ""
                DispatchQueue.main.async {
                     AppManager.share.naviView.lblAddress.text = AppManager.share.strAddress
                }
            }
        }) { (error) in
            print(error)
        }
    }
    
    func categoryApiCall() {
        let dict = ["Userid":AppManager.share.user.data.userID]
        CategoryViewModal.share.getCategory(param: dict, vc: self, successClosure: { (data) in
            if let dict = data as? [String:Any] {
                AppManager.share.category = Category(json: dict)
            }
        }) { (error) in
            SwAlert.showAlert("Incident Report", message: error, buttonTitle: "OK")
        }
    }
    
    func getParameterDataApiCall() {
        let dict = ["Userid":AppManager.share.user.data.userID,"ParameterKey":"IncidentImageCount"] as [String : Any]
        MapViewModal.share.getParameterData(param: dict, vc: self, successClosure: { (data) in
            if let dict = data as? [String:Any] {
                print(dict)
                if let data = dict["Data"] as? [[String:Any]] {
                    if let dict1 = data.first {
                        AppManager.share.IncidentImageCount = dict1["ParameterValue"] as? String ?? ""
                    }
                }
            }
        }) { (error) in
            SwAlert.showAlert("Incident Report", message: error, buttonTitle: "OK")
        }
    }
    
    
    @IBAction func btnIssuesListAction(sender:UIButton) {
        let vc = IssueListVC.loadFromNib()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnAddIssueAction(sender:UIButton) {
        let vc = CategoryVC.loadFromNib()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 10.0)
        AppManager.share.lat = location?.coordinate.latitude ?? 0.0
        AppManager.share.long = location?.coordinate.longitude ?? 0.0
        self.mapView.animate(to: camera)
        getAddressApiCall()
        self.addmark(lat: (location?.coordinate.latitude)!, long: (location?.coordinate.longitude)!)
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
}

