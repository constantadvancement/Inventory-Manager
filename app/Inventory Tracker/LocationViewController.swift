//
//  PermissionView.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/22/20.
//

import Cocoa
import CoreLocation
import MapKit

class LocationViewController: NSViewController, CLLocationManagerDelegate {
    @IBOutlet var continueButton: NSButton!
    @IBOutlet var permissionsField: NSTextField!
    @IBOutlet var mapView: MKMapView!
    
    var locationManager: CLLocationManager?
    var locationService: LocationService?
    
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
        
        // Disables the continue button (until the location and address are determined)
        continueButton.isEnabled = false
        
        // Adds location service observers
        let nc = NotificationCenter.default
        // Location service status notifications
        nc.addObserver(self, selector: #selector(authorizedStatus), name: .authorized, object: nil)
        nc.addObserver(self, selector: #selector(deniedStatus), name: .denied, object: nil)
        nc.addObserver(self, selector: #selector(notDeterminedStatus), name: .notDetermined, object: nil)
        
        // Location data notifications
        nc.addObserver(self, selector: #selector(locationFound), name: .locationFound, object: nil)
        nc.addObserver(self, selector: #selector(addressFound), name: .addressFound, object: nil)
        
        // Location error notification
        nc.addObserver(self, selector: #selector(locationError), name: .error, object: nil)
        
        // Requests the user's current location
        locationService = LocationService()
        locationService?.startUpdatingLocation()
    }
    
    // Location service notification handlers
    
    @objc func authorizedStatus() {
        print("Location service status: authorized")
        
        // Location services authorized (clicked OK to allow)
        permissionsField.stringValue = "Once setup has been completed this device's last known location will be reported periodically."
        permissionsField.textColor = NSColor.white
    }
    
    @objc func deniedStatus() {
        print("Location service status: denied or restricted")
        
        // Location services denied or restricted
        permissionsField.stringValue = "You must enable location services for this application in order to continue!"
        permissionsField.textColor = NSColor.systemRed
    }
    
    @objc func notDeterminedStatus() {
        print("Location service status: not determined")
        
        // Location services not determined
        permissionsField.stringValue = "Click OK to enable location services for this applciation!"
        permissionsField.textColor = NSColor.white
    }
    
    @objc func locationFound() {
        print("Location was found!")
        
        let coordinate = LocationInfo.shared.coordinate!
        
        // Zoom to user location
        let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(viewRegion, animated: true)
        
        // Adds current location annotation
        addAnnotation(at: coordinate)
    }
    
    @objc func addressFound() {
        print("Address was found!")
        
        // Enables the continue button
        continueButton.isEnabled = true
        
        // Removes location service observers
        let nc = NotificationCenter.default
        // Location error notification
        nc.removeObserver(self, name: .error, object: nil)
        
        // Location service status notifications
        nc.removeObserver(self, name: .authorized, object: nil)
        nc.removeObserver(self, name: .denied, object: nil)
        nc.removeObserver(self, name: .notDetermined, object: nil)
        
        // Location data notifications
        nc.removeObserver(self, name: .locationFound, object: nil)
        nc.removeObserver(self, name: .addressFound, object: nil)
    }
    
    @objc func locationError() {
        print("Location error occured")
        
        // Removes location service observers
        let nc = NotificationCenter.default
        // Location error notification
        nc.removeObserver(self, name: .error, object: nil)
        
        // Location service status notifications
        nc.removeObserver(self, name: .authorized, object: nil)
        nc.removeObserver(self, name: .denied, object: nil)
        nc.removeObserver(self, name: .notDetermined, object: nil)
        
        // Location data notifications
        nc.removeObserver(self, name: .locationFound, object: nil)
        nc.removeObserver(self, name: .addressFound, object: nil)
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
