//
//  MapViewController.swift
//  TravelWishList
//
//  Created by Cara on 3/2/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UITableViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    var placeModel: PlaceList! // This is showing as nil right now, figure out why
    
    override func loadView() {
        // set a MKMapView programmatically
        mapView = MKMapView()
        
        // set it as *the* view for this view controller
        view = mapView
        
        // add a button programmatically
        let button = UIButton(type: .roundedRect)
        
        let buttonX = 30
        let buttonY = 80
        let buttonWidth = 300
        let buttonHeight = 50
        
        button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        button.backgroundColor = UIColor.magenta
        button.setTitle("Add Place?", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        
        // gesture recognizer
        let pressLong = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.mapPressLonger(_:)))
        pressLong.minimumPressDuration = 1.0 // seconds
        // add the gesture recognition
        mapView.addGestureRecognizer(pressLong)
        let _: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeModel.count()
    }
    
    @objc func buttonClicked(sender: UIButton){
        // update the PlacesList with the Place information would be cool
        //placeModel.add(newPlace)
    }
    
    // function called when gesture recognizer detects a longer press
    @objc func mapPressLonger(_ recognizer: UIGestureRecognizer) {
        print("activated gesture recognizer for long press")
        
        // add the location on the view that was touched
        let placeTouched = recognizer.location(in: self.mapView)
        // get the coordinates of the place that was touched
        let placeTouchedCoordinate: CLLocationCoordinate2D = mapView.convert(placeTouched, toCoordinateFrom: self.mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placeTouchedCoordinate
        mapView.addAnnotation(annotation)
        
        // reverse Geocode and create a Place object
        var placeName = String() // This is not getting changed in geoCoder, is there an error? 
        let placeLat = placeTouchedCoordinate.latitude
        let placeLong = placeTouchedCoordinate.longitude
        let location: CLLocation = CLLocation(latitude: placeLat, longitude: placeLong)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: {(placeMarks: [CLPlacemark]?, error: Error?) in if error == nil {
                let placeMark = placeMarks![0]
            placeName = self.reverseGeoCodeComplete(location: placeMark)
            }
        })
            let newPlace = Place(name: placeName, hasVisited: false, latitude: placeLong, longitude: placeLong)
       //Crash here
        //self.placeModel.add(newPlace)
        print(self.placeModel != nil)
        
    }
    
    // Reuse annotation pins whenever possible
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "pin"
        var pinAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if pinAnnotation == nil {
            pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinAnnotation!.canShowCallout = true
            // customize these further
            
        } else {
            pinAnnotation!.annotation = annotation
        }
        return pinAnnotation
    }
    
    func reverseGeoCodeComplete(location: CLPlacemark) -> String {
        var locationString: String = ""
        if location.name != nil {
            locationString = "\(location.name!)"
        }
        return locationString
    }
}
