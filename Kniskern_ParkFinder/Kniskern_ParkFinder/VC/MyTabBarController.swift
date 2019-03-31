//
//  MyTabBarController.swift
//  Kniskern_ParkFinder
//
//  Created by Student on 3/31/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let viewControllers = self.viewControllers{
            for vc in viewControllers{
                if let vc = vc as? ViewController{
                    vc.parkData = ParkData.shared
                }
                if let vc = vc as? UINavigationController, let topVC = vc.topViewController as? ParksTableVC{
                    topVC.parkData = ParkData.shared
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
