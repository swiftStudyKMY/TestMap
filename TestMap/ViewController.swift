//
//  ViewController.swift
//  TestMap
//
//  Created by 김민영 on 2019/12/19.
//  Copyright © 2019 김민영. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    var mapView: GMSMapView!
        var myMarker = GMSMarker()
        let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapView.settings.compassButton = true
        
        mapView.settings.myLocationButton = true
        
        mapView.isMyLocationEnabled = true
        
        self.locationManager.startUpdatingLocation()
    }
    
    override func loadView() {
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
////        mapView.isMyLocationEnabled = true
//        view = mapView
//
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
        mapView = GMSMapView()
        view = mapView
    }
    
      override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            
            // 사용할때만 위치정보를 사용한다는 팝업이 발생
    //        locationManager.requestWhenInUseAuthorization()
            
            // 항상 위치정보를 사용한다는 판업이 발생
            locationManager.requestAlwaysAuthorization()
            
            locationManager.startUpdatingLocation()
            
            move(at: locationManager.location?.coordinate)
        }
}

extension ViewController{
    
      func move(at coordinate: CLLocationCoordinate2D?) {
            guard let coordinate = coordinate else {
                return
            }
            
            print("move = \(coordinate)")
            
            let latitude = coordinate.latitude
            let longitude = coordinate.longitude
            
            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 14.0)
            mapView.camera = camera
            
            myMarker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            myMarker.title = "My Position"
            myMarker.snippet = "Known"
            myMarker.map = mapView
        }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else {
            return
        }
        
        move(at: firstLocation.coordinate)
    }
}
