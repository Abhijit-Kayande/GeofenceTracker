//
//  GeofenceTracker.swift
//  Geofence
//
//  Created by abhijit kayande on 22/04/21.
//  Copyright © 2021 Abhijit. All rights reserved.
//

import Foundation
import CoreData

final class GeofenceTracker: NSObject, LocationManagerDelegate {
    static let sharedInstance = GeofenceTracker()
    let locationManager = LocationManager()
    let geofenceManager = GeofenceManager()
    
    func initializeLocationManager(){
        locationManager.delegate = self
        locationManager.initializeLocationManager()
    }
    
    func addGeofence(id: String, name: String, lat:Double, lng:Double, radius:Int32) {
        geofenceManager.addGeofence(id: id, name: name, lat: lat, lng: lng, radius: radius)
        locationManager.addCircularRegion(id: id, lat: lat, lng: lng, radius: radius)
    }
    
    func geofenceFetchedResultsController() ->NSFetchedResultsController<Geofence>{
        return geofenceManager.fetchedResultsController
    }
    
    // MARK: LocationManagerDelegate Methods
    func didUpdateRegion(id: String, isEntered: Bool) {
        geofenceManager.updateGeofence(id: id, isEntered: isEntered)
    }
}

