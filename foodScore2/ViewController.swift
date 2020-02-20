//
//  ViewController.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/17.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import UIKit
import GoogleMaps
//import GooglePlaces


class ViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate  {
    
    @IBOutlet var mapView: GMSMapView!
    //var placesClient: GMSPlacesClient!
    var locationManager :CLLocationManager?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        //-----------------------追蹤位置--------------------------
        locationManager?.delegate = self
        //精準度
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        //模式
        locationManager?.activityType = .automotiveNavigation
        //觸發方法
        locationManager?.startUpdatingLocation()


        
        let camera = GMSCameraPosition(latitude: 22.9922500, longitude: 120.184950, zoom: 18.0)
        mapView.camera = camera
        mapView.delegate = self
        mapView.isMyLocationEnabled = true

        
        //placesClient = GMSPlacesClient()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation: CLLocation = locations[0] as CLLocation
        if let location = locations.first{

            CATransaction.begin()
            CATransaction.setValue(Int(2), forKey: kCATransactionAnimationDuration)
            mapView.animate(toLocation: location.coordinate)
            mapView.animate(toZoom: 18)
            CATransaction.commit()
            locationManager?.stopUpdatingLocation()
            
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {

        
        let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detail") as! DetailViewController
        detailController.name = name
        detailController.placeID = placeID
        present(detailController, animated: true, completion: nil)
    }
}

