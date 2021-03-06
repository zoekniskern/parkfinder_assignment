//
//  ParksTableVC.swift
//  Kniskern_ParkFinder
//
//  Created by Student on 3/24/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class ParksTableVC: UITableViewController {

    //var parks = [StatePark]()
    var parkData: ParkData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Parks"
        
        // TEST //
//        parks.append(StatePark(name: "Letchworth State Park", latitude: 42.685, longitude: -77.95944))
//        parks.append(StatePark(name: "Hamlin Beach State Park", latitude: 43.3619, longitude: -77.95861))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return parkData.parks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParkCell", for: indexPath)
        
        cell.textLabel?.text = parkData.parks[indexPath.row].title

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            guard selectedRow < parkData.parks.count else{
                print("row \(selectedRow) is not in parks!)")
                return
            }
            let detailVC = segue.destination as! ParkDetailTableVC
            detailVC.park = parkData.parks[selectedRow]
        }
    }
}
