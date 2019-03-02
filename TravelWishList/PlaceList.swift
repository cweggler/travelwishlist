//
//  PlaceList.swift
//  TravelWishList
//
//  Created by Cara on 3/2/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class PlaceList {
    var allPlaces = [Place]()
    
    func add(_ place: Place) -> Int {
        allPlaces.append(place)
        return allPlaces.endIndex - 1
    }
    
    func getPlace(at index: Int) -> Place? {
        if allPlaces.indices.contains(index){
            return allPlaces[index]
        }
        return nil
    }
    
    func count() -> Int {
        return allPlaces.count
    }
}
