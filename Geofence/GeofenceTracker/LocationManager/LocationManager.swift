//
//  LocationManager.swift
//  Geofence
//
//  Created by abhijit kayande on 22/04/21.
//  Copyright © 2021 Abhijit. All rights reserved.
//

import CoreLocation

protocol LocationManagerDelegate: class {
    func didUpdateRegion(id: String, isEntered:Bool)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
   static let sharedInstance = LocationManager()
    let kGPSRegionRadius = 50
    let manager : CLLocationManager = CLLocationManager()
    weak var delegate:LocationManagerDelegate?

    func initializeLocationManager(){
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        manager.distanceFilter = CLLocationDistance(kGPSRegionRadius);
        manager.activityType = .automotiveNavigation;
        manager.startUpdatingLocation()
        manager.startMonitoringSignificantLocationChanges()
    }
    
    func addCircularRegion(id: String, lat:Double, lng:Double, radius:Int32){
        let circularRegion: CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(lat, lng), radius: CLLocationDistance(radius), identifier: String(id))
        manager.startMonitoring(for: circularRegion)
        circularRegion.notifyOnEntry = true
        circularRegion.notifyOnExit = true
    }
    
    // MARK: CLLocationManagerDelegate Methods
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location status: \(status.rawValue)")
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("The monitored regions are: \(manager.monitoredRegions)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        self.delegate?.didUpdateRegion(id: region.identifier, isEntered: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        self.delegate?.didUpdateRegion(id: region.identifier, isEntered: false)
    }
    
}

