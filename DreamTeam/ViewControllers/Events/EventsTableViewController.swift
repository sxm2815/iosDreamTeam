//
//  EventsTableViewController.swift
//  DreamTeam
//
//  Created by Student on 12/16/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import Firebase

class EventsTableViewController: UITableViewController {
    
    var events: [Event] = [Event]()
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.ref?.child("Events").observeSingleEvent(of: .value, with: {(snapshot) in
            self.events = []
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                let value = snap.value as? NSDictionary
                
                let data: [String:AnyObject] = ["Title":value?["Title"] as AnyObject, "Description":value?["Description"] as AnyObject, "Date":value?["Date"] as AnyObject]
                let event = Event(dictionary: data, key: key)
                self.events.append(event)
            }
            self.tableView.reloadData()
        })
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.events.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        let eachEvent = events[indexPath.row]
        cell.textLabel?.text = eachEvent.title
        cell.detailTextLabel?.text = eachEvent.date

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
        
        if segue.identifier == "toDatePopupViewControllerSegue" {
            let popup = segue.destination as! DatePickViewController
            // this is where the view controlelr is going to
            // have to cast it as that type cause it doesn't know initially
            popup.showTimePicker = true
        }
        let indexPath = tableView.indexPathForSelectedRow
        let eventData = self.events[indexPath!.row]
        
        let detailVC = segue.destination as! EventDetailViewController
        detailVC.title = eventData.title
        detailVC.dateText = eventData.date
        detailVC.descText = eventData.desc
        
        
    }

}
