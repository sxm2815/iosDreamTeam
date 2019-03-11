//
//  CalendarViewController.swift
//  DreamTeam
//
//  Created by Student on 12/15/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import Foundation
import Firebase

enum MyTheme {
    case light
    case dark
}

class CalendarViewController: UIViewController {
    var ref: DatabaseReference!
    let userName = Auth.auth().currentUser?.displayName
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var theme = MyTheme.dark
    
    @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Calender"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.isTranslucent=false
        self.view.backgroundColor=Style.bgColor
        
        ref = Database.database().reference()
        
        view.addSubview(calenderView)
        calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive=true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive=true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive=true
        calenderView.heightAnchor.constraint(equalToConstant: 365).isActive=true
        
//        let rightBarBtn = UIBarButtonItem(title: "Light", style: .plain, target: self, action: #selector(rightBarBtnAction))
//        self.navigationItem.rightBarButtonItem = rightBarBtn
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePopupClosing), name: .saveDateTime, object: nil)
//            --> this is the old way of adding observers
//        NotificationCenter.default.addObserver(forName: .saveDateTime, object: nil, queue: OperationQueue.main) { (notification) in }
        // uses a completion handler instead of the old one,
        // Operation Queses -->  what thread you should it on
        // main threads -->  where servicing of events and the updating of an app's user interface takes palce
        // background -->basically any other queue or threat that isn't main. kinda/sorta. stuff not happening on UI
        // nil --> runs on the same thread that it was posted on
        
        
    }
    
    @objc func handlePopupClosing(notification: Notification) { //have to use this objective C function
        let dateVC = notification.object as! DatePickViewController // because object can be of any type
        
        let eventId = dateVC.eventTitle.text + (userName ?? "NoUserName")
        let data = ["Title": dateVC.eventTitle.text, "Date":dateVC.formattedDate, "Description": dateVC.eventDescription.text] as [String : Any]
        
        self.ref.child("Events").child(eventId).updateChildValues(data)
    }
    
    // used as a call right before segue is called
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDatePopupViewControllerSegue" {
            let popup = segue.destination as! DatePickViewController
            // this is where the view controlelr is going to
            // have to cast it as that type cause it doesn't know initially
            popup.showTimePicker = false
        }
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
//    @objc func rightBarBtnAction(sender: UIBarButtonItem) {
//        if theme == .dark {
//            sender.title = "Dark"
//            theme = .light
//            Style.themeLight()
//        } else {
//            sender.title = "Light"
//            theme = .dark
//            Style.themeDark()
//        }
//        self.view.backgroundColor=Style.bgColor
//        calenderView.changeTheme()
//    }
    
    
    
    let calenderView: CalenderView = {
        let v=CalenderView(theme: MyTheme.dark)
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

