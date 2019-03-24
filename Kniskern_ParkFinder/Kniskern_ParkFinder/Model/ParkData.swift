//
//  ParkData.swift
//  Kniskern_ParkFinder
//
//  Created by Student on 3/24/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class ParkData{
    static let shared = ParkData()
    var parks = [StatePark]()
    
    private init(){
        print("Park Data created")
    }
}
