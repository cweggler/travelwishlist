//
//  PlacesViewController.swift
//  TravelWishList
//
//  Created by Cara on 3/2/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class PlacesViewController: UITableViewController {
    var placeModel: PlaceList! //injects the placelist into this controller
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeModel.allPlaces.count //crashes right here because it saws there is nil when unwrapped
    }
    
    // add code for dequeable cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
        
        // set the text on the cell with the place's attributes
       let place = placeModel.allPlaces[indexPath.row]
    
        // configure the cell with the Place
        cell.nameLabel.text = place.name
        if place.hasVisited == true {
            cell.visitedLabel.text = "Visited"
        } else {
            cell.visitedLabel.text = "Not Visited"
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(placeModel != nil, "placeModel should be set first")
    }
}
