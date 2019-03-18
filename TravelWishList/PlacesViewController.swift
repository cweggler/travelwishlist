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
    var map: MapViewController!
   
    
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
            //maybe add some color to the cells in each section?
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
        //maybe add some color to the cells in each section?
        cell.nameLabel.text = place.name
        if place.hasVisited == true {
            cell.visitedLabel.text = "Visited"
        } else {
            cell.visitedLabel.text = "Not Visited"
        }
        return cell
    }
    
    // add the editingStyle to allow for the Delete button
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // This code is for what happens when a user wants to delete a Place
        let place = self.placeModel.allPlaces[indexPath.row]
        if editingStyle == .delete {
            
            let title = "Delete \(place.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                                             handler: { (action) -> Void in
                                                
            let annotationToRemove = self.map.annotationList.remove(at: indexPath.row)
            // Remove the place from the model
            self.placeModel.removePlace(place)
            
            //Also remove that row from the table view with an animation
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //Also remove that annotation from MapView
            if let annotation = self.map.annotationDict.removeValue(forKey: annotationToRemove){
                self.map.mapView.removeAnnotation(annotation)
            }
            
        })
            ac.addAction(deleteAction)
            // Present the alert controller
            present(ac, animated: true, completion: nil)
            
       }
            
    }
    
    // add a leading swipe button to change a place from NotVisited to Visited
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let visited = UIContextualAction(style: .normal, title: "Visited?") { (action, view, nil) in
            print("Change to visited or not visited")
        }
        return UISwipeActionsConfiguration(actions: [visited])
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
