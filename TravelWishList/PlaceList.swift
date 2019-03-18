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
    
    @discardableResult func add(_ place: Place) -> Int {
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
    
    func notVisitedCount() -> Int {
        var count = 0
        for i in allPlaces {
            if (i.hasVisited == false) {
                count += 1
            }
        }
        return count
    }
    
    func visitedCount() -> Int {
        var count = 0
        for i in allPlaces {
            if(i.hasVisited == true) {
                count += 1
            }
        }
        return count
    }
    
    func removePlace(_ place: Place){
        if let index = allPlaces.index(of: place){
            allPlaces.remove(at: index)
        }
    }
    
    
}
