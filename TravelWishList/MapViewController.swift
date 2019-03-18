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
    let locationManager = CLLocationManager()
    
    //My Dependency Injections
    var placeModel: PlaceList!
    var table: PlacesViewController!
    
    let geoCoder = CLGeocoder()
    
    var newPlace = Place() // create a place variable so the long gesture can implement this
    var annotationList = [String]()
    var annotationDict = [String: MKAnnotation]()
    
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var button: UIButton!
    
    override func loadView() {
        // set a MKMapView programmatically
        mapView = MKMapView()
        
        // set it as *the* view for this view controller
        view = mapView
        
        // add a button programmatically
        button = UIButton(type: .roundedRect)
        
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
    
    @objc func buttonClicked(sender: UIButton){
        // update the PlacesList with the Place information
        placeModel.add(newPlace)
        
        // Here to check the action
        print("I am clicked")
        print(self.newPlace.name)
    }
    
    // function called when gesture recognizer detects a longer press
    
    @objc func mapPressLonger(_ recognizer: UIGestureRecognizer) {
        print("activated gesture recognizer for long press")
        
        //        //Check if the button was clicked if not, remove the previous annotation
        //        if button.isSelected == false && annotationList.isEmpty != true {
        //                self.mapView.removeAnnotation(annotationList[annotationList.count-1]) //get the previous annotation
        //                annotationList.removeLast()
        //                print("Removed previous annotation")
        //        }
        // add the location on the view that was touched
        let placeTouched = recognizer.location(in: self.mapView)
        // get the coordinates of the place that was touched
        let placeTouchedCoordinate: CLLocationCoordinate2D = mapView.convert(placeTouched, toCoordinateFrom: self.mapView)
        
        //if(self.mapView.annotations.count != placeModel.count()) {
        //Remove the annotation before adding a new one
        //[self.mapView removeAnnotation:[self.mapView.annotations objectAtIndex:0]]; }
        //}
        
        // create an annotation and its coordinate
        let annotation = MKPointAnnotation()
        annotation.coordinate = placeTouchedCoordinate
        
        
        // reverse Geocode and create a Place object
        var placeName = String()
        let placeLat = placeTouchedCoordinate.latitude
        let placeLong = placeTouchedCoordinate.longitude
        let location: CLLocation = CLLocation(latitude: placeLat, longitude: placeLong)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: {(placeMarks: [CLPlacemark]?, error: Error?) in if error == nil {
            let placeMark = placeMarks![0]
            //Want to keep a tidy record of the Annotations in case they need to be removed later
            annotation.title = placeMark.name
            
            //            if  let streetNumber = placeMark.subThoroughfare,
            //                let city = placeMark.locality,
            //                let state = placeMark.administrativeArea {
            //                annotation.subtitle = "\(streetNumber) \(city) \(state)"
            //            }
            
            self.mapView.addAnnotation(annotation)
            self.annotationList.append(annotation.title!)
            self.annotationDict.updateValue(annotation, forKey: annotation.title!)
            
            if placeMark.name != nil {
                placeName = placeMark.name!
            }
            else {
                placeName = " "
            }
            self.newPlace = Place(name: placeName, hasVisited: false, latitude: placeLong, longitude: placeLong)
            
            print(self.newPlace.name)
            }
        })
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
    
    //    func reverseGeoCodeComplete(location: CLPlacemark) -> String {
    //        var locationString: String = ""
    //        if location.name != nil {
    //            locationString = "\(location.name!)"
    //        }
    //        return locationString
    //    }
    
    
}
