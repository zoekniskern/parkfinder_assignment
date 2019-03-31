//
//  AppDelegate.swift
//  Kniskern_ParkFinder
//
//  Created by Student on 3/23/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

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
    }//end of load data
    
    //parse func for json
    func parse(json:[String:Any]){
        
        var parks = [StatePark]()
        
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
            
            print(newPark)
            parks += [newPark]
            ParkData.shared.parks = parks
            
        }
    }//end of parse
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        loadData()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

