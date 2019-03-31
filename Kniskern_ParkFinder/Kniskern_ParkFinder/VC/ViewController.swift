//
//  ViewController.swift
//  Kniskern_ParkFinder
//
//  Created by Student on 3/23/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import MapKit

let showParkOnMapNotification = NSNotification.Name("showParkOnMapNotification")
let isPad = UIDevice.current.userInterfaceIdiom == .pad

class ViewController: UIViewController, MKMapViewDelegate {
    
    //var parks = [StatePark]()
    @IBOutlet weak var mapView: MKMapView!
    let metersPerMile:Double = 1609.344
    var parkData: ParkData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        //loadData()
        //use instead
        //parks = ParkData.shared.parks
        
        //get notification center - its a singleton
        let nc = NotificationCenter.default
        
        //register as an observer
        nc.addObserver(self, selector: #selector(showMap), name: showParkOnMapNotification, object: nil)
        
        //ADD ANNOTATION
        mapView.addAnnotations(parkData.parks)
        
        //ZOOM IT
        let nyRegion = MKCoordinateRegion(center: parkData.parks[0].coordinate, latitudinalMeters: metersPerMile * 100, longitudinalMeters: metersPerMile * 100)
        mapView.setRegion(nyRegion, animated: true)
        //First Park is selected
        mapView.selectAnnotation(parkData.parks[0], animated: true)
        
    } //end of viewdidload
    
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
    
    // MARK: - Notifications
    @objc func showMap(notification: NSNotification){
        //change to map tab - this works as long as the map is on first tab
        tabBarController?.selectedIndex = 0
        
        //select the park annotation that was passed over
        if let park = notification.userInfo!["park"] as? MKAnnotation{
            mapView.selectAnnotation(park, animated: true)
        }
    }
    
    // MARK: - Cleanup
    deinit{
        NotificationCenter.default.removeObserver(self)
    }


}

