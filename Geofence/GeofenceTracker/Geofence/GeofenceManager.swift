//
//  GeofenceManager.swift
//  Geofence
//
//  Created by abhijit kayande on 22/04/21.
//  Copyright © 2021 Abhijit. All rights reserved.
//

import Foundation
import CoreData

class GeofenceManager: NSObject {
    func addGeofence(id: String, name: String, lat:Double, lng:Double, radius:Int32) {
        let managedContext = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Geofence",
                                   in: managedContext)!
        let geofence = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
        geofence.setValue(id, forKeyPath: "id")
        geofence.setValue(name, forKeyPath: "name")
        geofence.setValue(lat, forKeyPath: "lat")
        geofence.setValue(lng, forKeyPath: "lng")
        geofence.setValue(radius, forKeyPath: "radius")
        geofence.setValue(false, forKeyPath: "isEntered")
      
      do {
        try managedContext.save()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    func updateGeofence(id:String, isEntered:Bool){
        let fetchRequest = NSFetchRequest<Geofence>(entityName: "Geofence")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        let managedContext = self.persistentContainer.viewContext
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not update. \(error), \(error.userInfo)")
        }
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let geofence = results.first {
              geofence.isEntered = isEntered
            }
            try managedContext.save()
        } catch {
            print("Unable to update")
        }
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GeofenceTracker")
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController<Geofence> = {
        let fetchRequest = NSFetchRequest<Geofence>(entityName: "Geofence")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
         
        let managedContext = self.persistentContainer.viewContext
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
         
        return fetchedResultsController
    }()
        
}
