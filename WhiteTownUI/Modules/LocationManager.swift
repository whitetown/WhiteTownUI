//
//  LocationManager.swift
//  SynchroSnap
//
//  Created by Sergey Chehuta on 29/02/2020.
//  Copyright © 2020 WhiteTown. All rights reserved.
//

import Foundation
import CoreLocation

public extension Notification.Name {
    static let locationStatusDidChange = Notification.Name("locationStatusDidChange")
    static let locationDidChange = Notification.Name("locationDidChange")
}

public class LocationManager: NSObject {
    
    public static let shared = LocationManager()
 
    private let locationManager = CLLocationManager()
    private(set) public var status: CLAuthorizationStatus = CLLocationManager.authorizationStatus() {
        didSet {
            NotificationCenter.default.post(name: .locationStatusDidChange, object: self.status)
            updateLocationState()
        }
    }
    
    private var locationTime = Date().addingTimeInterval(-60)
    private(set) public var currentLocation: CLLocationCoordinate2D? = nil {
        didSet {
            if Date().timeIntervalSince(locationTime) > 60 {
                self.locationTime = Date()
                guard let location = self.currentLocation else { return }
                NotificationCenter.default.post(name: .locationDidChange, object: location)
            }
        }
    }

    override public init() {
        super.init()
        initialize()
    }
        
    private func initialize() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.status = CLLocationManager.authorizationStatus()
    }
    
    private func updateLocationState() {
        if  self.isEnabled {
            self.locationManager.startUpdatingLocation()
        } else {
            self.locationManager.stopUpdatingLocation()
        }
    }

    public func onLocationStateChange(_ value: Bool) {
        if value {
            self.locationManager.requestAlwaysAuthorization()
            self.updateLocationState()
        } else {
            self.updateLocationState()
        }
    }
    
    public var isEnabled: Bool {
        return CLLocationManager.locationServicesEnabled()
               && (self.status == .authorizedAlways || self.status == .authorizedWhenInUse)
    }

    public var isDisabled: Bool {
        return CLLocationManager.locationServicesEnabled() == false
            || self.status == .denied
            || self.status == .restricted
    }

}


extension LocationManager: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate: CLLocationCoordinate2D = manager.location?.coordinate {
            //print("locations = \(coordinate.latitude) \(coordinate.longitude)")
            self.currentLocation = coordinate
        } else {
            self.currentLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
    
}

public extension CLLocationDistance {
    
    func asString() -> String {
        if self == 0 { return "" }
        if self < 1000 { return String(format: "%dm", Int(self)) }
        
        let km: Int = Int(self/1000)
        let m:  Int = Int((self - Double(km*1000))/10)
        if km < 10 {
            return String(format: "%d.%dkm", Int(km), Int(m))
        } else {
            return String(format: "%dkm", Int(km))
        }
    }
    
}
