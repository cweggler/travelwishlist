//
//  PlacesViewController.swift
//  TravelWishList
//
//  Created by Cara on 3/2/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class PlacesViewController: UITableViewController {
    var placeList: PlaceList!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.allPlaces.count
    }
    
    // add code for dequeable cells
    
}
