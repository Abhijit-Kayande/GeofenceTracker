# GeofenceTracker
## How to test
- Run the application in iOS simulator
- While the simulator is selected, Go to the Features->Location->Custom Location
- Enter following location coordinates
- - latitude: 40.7484, Longitude: 73.9857 for "Empire State Building"
- - latitude: 48.8584, Longitude: 2.2945 for "Eiffel Tower"
- - latitude: 25.1972, Longitude: 55.2744 for "Burj Khalifa"
- After entering respective location, see the status on the perticular cell in the simulator (It will show Entered/Exited depending on the state)

## Design Flow

![Geofence](https://user-images.githubusercontent.com/4660326/115708362-827edb00-a38d-11eb-89d9-16883c780ee7.jpg)

The purpose of this design is that each class should have single responsibility and different functionalities should be separated effectively. This will be easier in maintaining and expanding the Product.


**LocationManager -** The Core Location implementation is in this class. This class Requests the location permission from the user and track given circular regions and also notifies about them.

**GeofenceManager -** This class manages the Core Data stack and performs Save and Update operations on Geofence model.

**GeofenceTracker -** This class handles the interaction between Geofence Manager and Location Manager. It hides all the complexity and provides a simple interface.

**ViewController -** The ViewController uses Geofence Tracker to add new circular regions. It handles the UI using NSFetchedResultsController, provided by Geofence Tracker, and update the UI on real-time using NSFetchedResultsControllerDelegate methods.

