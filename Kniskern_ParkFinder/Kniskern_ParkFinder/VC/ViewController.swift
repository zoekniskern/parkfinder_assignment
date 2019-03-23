//
//  ViewController.swift
//  Kniskern_ParkFinder
//
//  Created by Student on 3/23/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //test park
        let park1 = StatePark(name:"Letchworth State Park", latitude: 42.685, longitude: -77.95944)
        print(park1)
        
        //load JSON data
        if let path = Bundle.main.url(forResource: "parks", withExtension: "json") {
            let data = try! Data.init(contentsOf: path)
            let json = try! JSONSerialization.jsonObject(with: data) as? [String: Any]
            print("json: \(String(desribing: json))")
        } else {
            print("Error: unable to load parks")
        }
    }


}

