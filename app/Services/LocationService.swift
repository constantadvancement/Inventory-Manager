//
//  LocationService.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 11/5/20.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    var notificationCenter: NotificationCenter?
    var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        
        self.notificationCenter = NotificationCenter.default
        
        self.locationManager = CLLocationManager()
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager?.delegate = self
    }
    
    func startUpdatingLocation() {
        locationManager?.startUpdatingLocation()
    }
    
    // Location manager delegate methods
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorized:
            // Location services authorized
            notificationCenter?.post(name: .authorized, object: nil)
        case .denied, .restricted:
            // Location services denied or restricted
            notificationCenter?.post(name: .denied, object: nil)
        case .notDetermined:
            // Location services not determined
            notificationCenter?.post(name: .notDetermined, object: nil)
        default:
            // This case should never occur
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let error = error as? CLError, error.code == .denied else {
            // Request denied error, bailing out
            locationManager?.stopUpdatingLocation()
            notificationCenter?.post(name: .error, object: nil)
            return
        }
        guard error.code == .network else {
            // Network connection error, bailing out
            locationManager?.stopUpdatingLocation()
            notificationCenter?.post(name: .error, object: nil)
            return
        }
        // Error; coordinates and address not found
        print("Location Manager Error: \(error) \nTrying again...")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Location found; stops updating this device's location
        locationManager?.stopUpdatingLocation()
        
        // Determines the user's last reported location
        let lastLocation = locations.last!
        
        // Saves the location data to the LocationInfo model
        let location = LocationInfo.shared
        location.coordinate = lastLocation.coordinate
        location.timestamp = convertToLocalDate(lastLocation.timestamp)
        
        // Location found notification
        notificationCenter?.post(name: .locationFound, object: nil)

        // Use geocoder to determine address from location coordinates
        let geocoder = CLGeocoder.init()
        geocoder.reverseGeocodeLocation(lastLocation) { [self] (placemarks: [CLPlacemark]?, error: Error?) in
            if error == nil, let placemark = placemarks?[0] {
                // Success; coordinates and address found
                completionHandler(placemark)
            } else {
                guard let error = error as? CLError, error.code == .network else {
                    // Network connection error, bailing out
                    notificationCenter?.post(name: .error, object: nil)
                    return
                }
                // Error; coordinates found but address not found
                print("Geocoder Error: \(error) \nTrying again...")
            }
        }
    }
    
    func completionHandler(_ placemark: CLPlacemark) {
        // Saves the address data to the LocationInfo model
        let location = LocationInfo.shared
        location.street = placemark.name
        location.city = placemark.locality
        location.state = placemark.administrativeArea
        location.zip = placemark.postalCode
        location.country = placemark.isoCountryCode
        
        // Address found notification
        notificationCenter?.post(name: .addressFound, object: nil)
    }
    
    // Helpers
    
    // Returns the specified date using this device's current time zone
    func convertToLocalDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
