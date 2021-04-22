//
//  ViewController.swift
//  Geofence
//
//  Created by abhijit kayande on 22/04/21.
//  Copyright © 2021 Abhijit. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var geofenceTableView: UITableView!
    var fetchedResultsController : NSFetchedResultsController<Geofence>?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let geofenceTracker = GeofenceTracker.sharedInstance
        geofenceTracker.initializeLocationManager()
        
        //Load Demo Data for testing
        geofenceTracker.addGeofence(id: "0", name: "Empire State Building", lat: 40.7484, lng: 73.9857, radius: 50)
        geofenceTracker.addGeofence(id: "1", name: "Eiffel Tower", lat: 48.8584, lng: 2.2945, radius: 50)
        geofenceTracker.addGeofence(id: "2", name: "Burj Khalifa", lat: 25.1972, lng: 55.2744, radius: 50)
        
        
        fetchedResultsController = geofenceTracker.geofenceFetchedResultsController()
        if (fetchedResultsController != nil) {
            do {
                fetchedResultsController?.delegate = self
                try fetchedResultsController!.performFetch()
            } catch {
                let fetchError = error as NSError
                print("\(fetchError), \(fetchError.userInfo)")
            }
        }
    }
    
    // MARK: NSFetchedResultsControllerDelegate Methods
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        geofenceTableView.reloadData()
    }
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeofenceCell", for: indexPath)
        if let geofenceList = fetchedResultsController?.fetchedObjects {
            let geofence: Geofence = geofenceList[indexPath.row]
            let geofenceNameLabel: UILabel = cell.viewWithTag(11) as! UILabel
            geofenceNameLabel.text = geofence.name
            let geofenceStatusLabel: UILabel = cell.viewWithTag(22) as! UILabel
            geofenceStatusLabel.text = geofence.isEntered ? "Entered" : "Exited"
        }
        return cell
    }


}

