//
//  Place.swift
//  TravelWishList
//
//  Created by Cara on 3/1/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit
import MapKit

class Place: NSObject { // If more time, may have wanted to make this extend the MKAnnotation protocol too
    var name: String                // Place's name
    var hasVisited: Bool            // T or F if Visited
    var latitude: CLLocationDegrees // latitude coordinates
    var longitude: CLLocationDegrees// longitude coordinates
  
    // designated initializer
    init(name: String, hasVisited: Bool, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        self.name = name
        self.hasVisited = hasVisited
        self.latitude = latitude
        self.longitude = longitude
        
        super.init()
    }
    
    // convenience initializer
    convenience override init() {
        let mName = ""
        let mHasVisited = false
        let mLatitude = 0.0
        let mLongitude = 0.0
        
        self.init(name: mName, hasVisited: mHasVisited, latitude: mLatitude, longitude: mLongitude)
    }
}
