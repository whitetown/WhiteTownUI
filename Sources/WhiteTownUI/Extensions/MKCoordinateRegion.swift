//
//  MKCoordinateRegion.swift
//  WhiteTownUI
//
//  Created by Sergey Chehuta on 18/03/2021.
//

import MapKit

public extension MKCoordinateRegion {

    var topLeft: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: center.latitude + span.latitudeDelta  / 2,
                                      longitude: center.longitude - span.longitudeDelta / 2)
    }
    var topRight: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: center.latitude + span.latitudeDelta  / 2,
                                      longitude: center.longitude + span.longitudeDelta / 2)
    }
    var bottomLeft: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: center.latitude - span.latitudeDelta  / 2,
                                      longitude: center.longitude - span.longitudeDelta / 2)
    }
    var bottomRight: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: center.latitude - span.latitudeDelta  / 2,
                                      longitude: center.longitude + span.longitudeDelta / 2)
    }
}

public extension MKAnnotationView {

    static var identifier: String {
        return String(describing: self)
    }

}

public extension CLLocationCoordinate2D {

     func distanceBetween(b: CLLocationCoordinate2D) -> CLLocationDistance {
         let aLocation = CLLocation(latitude:  self.latitude, longitude: self.longitude)
         let bLocation = CLLocation(latitude:  b.latitude, longitude: b.longitude)
         return aLocation.distance(from: bLocation)
     }

}

public extension MKCoordinateRegion {

    init?(coordinates: [CLLocationCoordinate2D], delta: Double = 0) {

        // first create a region centered around the prime meridian
        let primeRegion = MKCoordinateRegion.region(for: coordinates,
                                                    transform: { $0 },
                                                    inverseTransform: { $0 })

        // next create a region centered around the 180th meridian
        let transformedRegion = MKCoordinateRegion.region(for: coordinates,
                                                          transform: MKCoordinateRegion.transform,
                                                          inverseTransform: MKCoordinateRegion.inverseTransform)

        // return the region that has the smallest longitude delta
        if let a = primeRegion,
            let b = transformedRegion,
            let min = [a, b].min(by: { $0.span.longitudeDelta < $1.span.longitudeDelta }) {
            self = min
            self.span.latitudeDelta += delta
            self.span.longitudeDelta += delta
        }

        else if let a = primeRegion {
            self = a
            self.span.latitudeDelta += delta
            self.span.longitudeDelta += delta
        }

        else if let b = transformedRegion {
            self = b
            self.span.latitudeDelta += delta
            self.span.longitudeDelta += delta
        }

        else {
            return nil
        }
    }

    // Latitude -180...180 -> 0...360
    private static func transform(c: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        if c.longitude < 0 { return CLLocationCoordinate2DMake(c.latitude, 360 + c.longitude) }
        return c
    }

    // Latitude 0...360 -> -180...180
    private static func inverseTransform(c: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        if c.longitude > 180 { return CLLocationCoordinate2DMake(c.latitude, -360 + c.longitude) }
        return c
    }

    private typealias Transform = (CLLocationCoordinate2D) -> (CLLocationCoordinate2D)

    private static func region(for coordinates: [CLLocationCoordinate2D],
                               transform: Transform,
                               inverseTransform: Transform) -> MKCoordinateRegion? {

        // handle empty array
        guard !coordinates.isEmpty else { return nil }

        // handle single coordinate
        guard coordinates.count > 1 else {
            return MKCoordinateRegion(center: coordinates[0], span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        }

        let transformed = coordinates.map(transform)

        // find the span
        let minLat = transformed.min { $0.latitude < $1.latitude }!.latitude
        let maxLat = transformed.max { $0.latitude < $1.latitude }!.latitude
        let minLon = transformed.min { $0.longitude < $1.longitude }!.longitude
        let maxLon = transformed.max { $0.longitude < $1.longitude }!.longitude
        let span = MKCoordinateSpan(latitudeDelta: maxLat - minLat, longitudeDelta: maxLon - minLon)

        // find the center of the span
        let center = inverseTransform(CLLocationCoordinate2DMake((maxLat - span.latitudeDelta / 2), maxLon - span.longitudeDelta / 2))

        return MKCoordinateRegion(center: center, span: span)
    }
}
