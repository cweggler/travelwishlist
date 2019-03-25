//
//  MapViewController.swift
//  TravelWishList
//
//  Created by Cara on 3/2/19.
//  Copyright © 2019 Cara. All rights reserved.
//
import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //My Dependency Injections
    var placeModel: PlaceList!
    var table: PlacesViewController!
    
    let geoCoder = CLGeocoder() // need this to do the geocoding
    
    var newPlace = Place() // creates a place variable so the long gesture can implement this
    var annotationList = [String]() // creates an array of strings to keep track of our Annotations
    var annotationDict = [String: MKAnnotation]() // creates a dictionary to keep track of annotations
    
    
    @IBOutlet var mapView: MKMapView! // the mapView
    @IBOutlet var button: UIButton! // this button gets a global variable here
    
    override func loadView() {
        // set the MKMapView as *the* view for this view controller
        view = mapView
        
        // adds a button programmatically
        button = UIButton(type: .roundedRect)
        
        // sets the original point (x, y) and then width/height from there of button
        let buttonX = 50
        let buttonY = 80
        let buttonWidth = 300
        let buttonHeight = 50
        
        // sets up the button, color, text on button and action
        button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        button.backgroundColor = UIColor.magenta
        button.setTitle("Add Place?", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self // sets up the mapView delegate
        
        // this sets up the long press gesture recognizer
        let pressLong = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.mapPressLonger(_:)))
        pressLong.minimumPressDuration = 1.0 // seconds
        // add the gesture recognition
        mapView.addGestureRecognizer(pressLong)
        let _: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    }
    
    // this is important for the life cycle in going back and forth between views
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    // this is the action function when the Add Place? button is clicked
    @objc func buttonClicked(sender: UIButton){
        // update the PlacesList with the Place information
        placeModel.add(newPlace)
        
        // code here to check the action in the logs
        print("I am clicked")
        print(self.newPlace.name)
    }
    
    // function called when gesture recognizer detects a long press
    @objc func mapPressLonger(_ recognizer: UIGestureRecognizer) {
        print("activated gesture recognizer for long press")
        
        //Right now all annotations are saved until you come back from the Table View
        // This code below was an attempt to have the annotation removed when another is clicked.
        
        //        Check if the button was clicked if not, remove the previous annotation
        //        if button.isSelected == false && annotationList.isEmpty != true {
        //        self.mapView.removeAnnotation(annotationList[annotationList.count-1]) //get the previous annotation
        //                annotationList.removeLast()
        //                print("Removed previous annotation")
        
        
        // add the location on the view that was touched
        let placeTouched = recognizer.location(in: self.mapView)
        
        // get the coordinates of the place that was touched
        let placeTouchedCoordinate: CLLocationCoordinate2D = mapView.convert(placeTouched, toCoordinateFrom: self.mapView)
        
        // create an annotation and its coordinate
        let annotation = MKPointAnnotation()
        annotation.coordinate = placeTouchedCoordinate
        
        // initialize the variables to help create a Place object
        var placeName = String()
        let placeLat = placeTouchedCoordinate.latitude
        let placeLong = placeTouchedCoordinate.longitude
        let location: CLLocation = CLLocation(latitude: placeLat, longitude: placeLong)
        
        // reverse GeoCode to get a Place object
        geoCoder.reverseGeocodeLocation(location, completionHandler: {(placeMarks: [CLPlacemark]?, error: Error?) in if error == nil {
            let placeMark = placeMarks![0] // first of an array of CLPlacemarks
            
            //Want to show the title when the annotation is clicked
            annotation.title = placeMark.name
            
            // get information to set a subtitle, also shown when clicked
            var streetNumber = " "
            var city = " "
            var state = " "
            if placeMark.subThoroughfare != nil {streetNumber = placeMark.subThoroughfare!}
            if placeMark.locality != nil {city = placeMark.locality!}
            if placeMark.administrativeArea != nil {state = placeMark.administrativeArea!}
            annotation.subtitle = "\(streetNumber) \(city) \(state)"
            
            // add the annotation to view
            self.mapView.addAnnotation(annotation)
            
            // keep a tidy record of annotations to be able to easily remove later
            self.annotationList.append(annotation.title!)
            self.annotationDict.updateValue(annotation, forKey: annotation.title!)
            
            // prevents a nil object for the name of the place
            if placeMark.name != nil {
                placeName = placeMark.name!
            }
            else {
                placeName = " "
            }
            // Create a Place Object
            self.newPlace = Place(name: placeName, hasVisited: false, latitude: placeLat, longitude: placeLong)
            
            // Code here for debugging purposes
            print(self.newPlace.name)
            }
        })
    }
    
    // Reuse annotation pins whenever possible
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "pin"
        var pinAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
    
        
        if pinAnnotation == nil {
            pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinAnnotation!.canShowCallout = true
            
            //test the color change
            // this works
            //            pinAnnotation?.pinTintColor = .blue
            
            // how do you tie back to check the place's hasVisited attribute
            
            
        } else {
            pinAnnotation!.annotation = annotation
        }
        
        return pinAnnotation
    }
    
}
