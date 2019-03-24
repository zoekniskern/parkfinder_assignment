//
//  StatePark.swift
//  Kniskern_ParkFinder
//
//  Created by Student on 3/23/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

public class StatePark: NSObject, MKAnnotation {
    private var name: String
    private var latitude: Double
    private var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public override var description: String{
        return "\(name) : (\(latitude), \(longitude))"
    }
    
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(CLLocationDegrees(latitude), CLLocationDegrees(longitude))
    }
    
    //Computed Properties
    public var title:String?{
        return name
    }
    
    public var subtitle: String?{
        return "I Love NY"
    }
}
