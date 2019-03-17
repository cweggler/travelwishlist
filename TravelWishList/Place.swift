//
//  Place.swift
//  TravelWishList
//
//  Created by Cara on 3/1/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit
import MapKit

class Place: NSObject {
    var name: String
    var hasVisited: Bool
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    // info about a place's location from CLLocationCoordinate2D for example
    
    init(name: String, hasVisited: Bool, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        self.name = name
        self.hasVisited = hasVisited
        self.latitude = latitude
        self.longitude = longitude
        
        super.init()
    }
    
    convenience override init() {
        let mName = ""
        let mHasVisited = false
        let mLatitude = 0.0
        let mLongitude = 0.0
        
        self.init(name: mName, hasVisited: mHasVisited, latitude: mLatitude, longitude: mLongitude)
    }
}

