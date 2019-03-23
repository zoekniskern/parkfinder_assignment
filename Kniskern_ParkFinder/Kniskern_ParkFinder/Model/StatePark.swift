//
//  StatePark.swift
//  Kniskern_ParkFinder
//
//  Created by Student on 3/23/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public class StatePark: NSObject {
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
}
