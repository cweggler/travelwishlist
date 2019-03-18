//
//  PlacesViewController.swift
//  TravelWishList
//
//  Created by Cara on 3/2/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class PlacesViewController: UITableViewController {
    var placeModel: PlaceList!
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section0Label = UILabel()
        let section1Label = UILabel()
        
        section0Label.text = "Not Visited Yet"
        section0Label.backgroundColor = UIColor.red
        
        section1Label.text = "Visited"
        section1Label.backgroundColor = UIColor.purple
        
        if section == 0 {
            return section0Label
        } else {
            return section1Label
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return placeModel.notVisitedCount()
        }
        else {
            return placeModel.visitedCount()
        }
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
        
        cell.textLabel?.text = "Section:\(indexPath.section) Row:\(indexPath.row)"
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
