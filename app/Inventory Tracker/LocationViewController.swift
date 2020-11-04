//
//  PermissionView.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/22/20.
//
// This view controller is responsible for gathering all location data for this device. This includes its location and a corresponding timestamp.

import Cocoa
import CoreLocation
import MapKit

class LocationViewController: NSViewController, CLLocationManagerDelegate {
    @IBOutlet var continueButton: NSButton!
    @IBOutlet var permissionsField: NSTextField!
    @IBOutlet var mapView: MKMapView!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View styles
        view.wantsLayer = true
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 650, height: 74)
        layer.backgroundColor = NSColor.darkGray.cgColor
        layer.opacity = 0.4
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: 74, width: 650, height: 1)
        borderLayer.backgroundColor = NSColor.black.cgColor
        
        layer.addSublayer(borderLayer)
        view.layer?.addSublayer(layer)
        
        mapView.wantsLayer = true
        mapView.layer?.borderColor = NSColor.lightGray.cgColor
        mapView.layer?.borderWidth = 1.0
        
        // Disables the continue button until the location is determined
        continueButton.isEnabled = false
        
        // Creates the location manager and requests the user's current location
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
    }
    
    // Location manager methods
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorized:
            // Location services authorized (clicked OK to allow)
            permissionsField.stringValue = "Once setup has been completed this device's last known location will be reported periodically."
            permissionsField.textColor = NSColor.white
        case .denied, .restricted:
            // Location services denied or restricted
            permissionsField.stringValue = "You must enable location services for this application in order to continue!"
            permissionsField.textColor = NSColor.systemRed
        case .notDetermined:
            // Location services not determined
            permissionsField.stringValue = "Click OK to enable location services for this applciation!"
            permissionsField.textColor = NSColor.white
        default:
            // This case should never occur
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Error; coordinates and address not found
        print("Location Manager Error: \(error) \nTrying again...")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Determines the user's last reported location
        let lastLocation = locations.last!
        
        // Zoom to user location
        let viewRegion = MKCoordinateRegion(center: lastLocation.coordinate, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(viewRegion, animated: true)
        
        // Adds current location annotation
        addAnnotation(at: lastLocation.coordinate)
        
        // Use geocoder to determine address from location coordinates
        let geocoder = CLGeocoder.init()
        geocoder.reverseGeocodeLocation(lastLocation) { (placemarks: [CLPlacemark]?, error: Error?) in
            if error == nil, let placemark = placemarks?[0] {
                // Success; coordinates and address found
                self.completionHandler(placemark, lastLocation.timestamp)
            } else {
                // Error; coordinates found but address not found
                print("Geocoder Error: \(error!) \nTrying again...")
            }
        }
    }
    
    func completionHandler(_ placemark: CLPlacemark, _ timestamp: Date) {
        print("Success: Found a location and address.")
        // Stops calling for location updates (TODO .... handle recurring location pings)
        locationManager?.stopUpdatingLocation()
        
        // Saves the location data to the LocationInfo model
        let location = LocationInfo.shared
        
        let localDate = convertToLocalDate(timestamp)
        location.timestamp = localDate
    
        location.street = placemark.name
        location.city = placemark.locality
        location.state = placemark.administrativeArea
        location.zip = placemark.postalCode
        location.country = placemark.isoCountryCode
        
        // Enables the continue button
        continueButton.isEnabled = true
    }
    
    // Helpers
    
    // Adds an annotation to the map view at the specified coordinates
    func addAnnotation(at coordinate: CLLocationCoordinate2D) {
        // Removes any existing annotations
        let annotations = mapView.annotations
        for annotation in annotations {
            mapView.removeAnnotation(annotation)
        }
        // Adds the new annotation for the specified coordinate
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Current Location"
        mapView.addAnnotation(annotation)
    }
    
    // Returns the specified date using this device's current time zone
    func convertToLocalDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    // Navigation button actions
    
    @IBAction func backButton(_ sender: Any) {
        if let controller = self.storyboard?.instantiateController(withIdentifier: "ProvisionViewController") as? ProvisionViewController {
            self.view.window?.contentViewController = controller
        }
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if let controller = self.storyboard?.instantiateController(withIdentifier: "ServerViewController") as? ServerViewController {
            self.view.window?.contentViewController = controller
        }
    }
    
}
