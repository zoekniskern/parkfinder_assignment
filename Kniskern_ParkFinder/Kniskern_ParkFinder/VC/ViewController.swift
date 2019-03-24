//
//  ViewController.swift
//  Kniskern_ParkFinder
//
//  Created by Student on 3/23/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    var parks = [StatePark]()
    @IBOutlet weak var mapView: MKMapView!
    let metersPerMile:Double = 1609.344
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        loadData()
        
        //test park
//        let park1 = StatePark(name:"Letchworth State Park", latitude: 42.685, longitude: -77.95944)
//        print(park1)
//
        
    } //end of viewdidload
    
    //load data func
    func loadData(){
        /////////////// load JSON data ////////////////
        // Round 1
        //        if let path = Bundle.main.url(forResource: "parks", withExtension: "json") {
        //            let data = try! Data.init(contentsOf: path)
        //            let json = try! JSONSerialization.jsonObject(with: data) as? [String: Any]
        //            print("json: \(String(describing: json))")
        //        } else {
        //            print("Error: unable to load parks.json")
        //        }
        // Round 2
        guard let path = Bundle.main.url(forResource: "parks", withExtension: "json") else {
            print("Error: could not find parks.json")
            return //gtfo
        }
        
        do { //do/catch because try throws exceptions if it fails
            // TEST // let path = URL(fileURLWithPath: "badpath.js")
            let data = try Data(contentsOf: path)
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]{
                parse(json: json)
            }
        } catch {
            print("Error: could not initialize the json data: \(error)")
        }
    }
    
    //parse func for json
    func parse(json:[String:Any]){
        //will implement more
        //print("json: \(String(describing: json))")
        //implementing more
        guard let parksArrayJSON = json["parks"] as? [AnyObject] else{
            print("ERROR: Could not find the 'parks' key")
            return
        }
        // TEST // print("parksArrayJSON: \(String(describing: parksArrayJSON))")
        
        for park in parksArrayJSON{
            //Is it a string? Assign the value to "name". Otherwise give it a value of "no name"
            //NAME
            let name = park["name"] as? String ?? "No name"
            //print(name)
            
            //LAT
            let latitudeString = park["latitude"] as? String ?? "0.0"
            //convert to Double for StatePark class format
            let latitude = Double(latitudeString) ?? 0.0
            //print(latitude)
            
            //LONG
            let longitudeString = park["longitude"] as? String ?? "0.0"
            //convert to Double for StatePark class format
            let longitude = Double(longitudeString) ?? 0.0
            //print(longitude)
            
            let newPark = StatePark(name: name, latitude: latitude, longitude: longitude)
            
            //print(newPark)
            parks += [newPark]
            ParkData.shared.parks = parks
            
            //ADD ANNOTATION
            mapView.addAnnotations(ParkData.shared.parks)
            
            //ZOOM IT
            let nyRegion = MKCoordinateRegion(center: parks[0].coordinate, latitudinalMeters: metersPerMile * 100, longitudinalMeters: metersPerMile * 100)
            mapView.setRegion(nyRegion, animated: true)
            //First Park is selected
            mapView.selectAnnotation(parks[0], animated: true)
        }
    }//end of parse
    
    // MARK: -MKMapViewDelegate protocol methods-
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let title = view.annotation?.title ?? "no title found"{
            print("Tapped \(String(describing: title))")
        }
    }
    
    //Add button to annotation and detect taps
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? StatePark else{
            print("This annotation isn't a StatePark")
            return nil
        }
        
        let identifier = "pinIdentifier"
        let view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            //reuse an existing view
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else{
            //make a new view and put a button on it
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? StatePark else {
            print("This annotation isn't a State Park")
            return
        }
        
        print("Tapped info button fpr \(annotation.description)")
        print("Do something interesting like visit URL, open in Maps etc")
    }


}

