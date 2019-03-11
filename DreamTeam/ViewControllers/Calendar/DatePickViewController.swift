//
//  DatePickViewController.swift
//  DreamTeam
//
//  Created by Student on 12/16/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class DatePickViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var eventTitle: UITextView!
    @IBOutlet weak var eventDescription: UITextView!
    var showTimePicker: Bool = false
    
    @IBAction func saveDate_TouchUpInside(_ sender: Any) {
        // setting up notification --> pretty much an observable
        // name --> name of the observable
        // object --> observable, thing being observed, what object is listening to
        NotificationCenter.default.post(name: Notification.Name.saveDateTime, object: self)
        // we have the notification name set in a model class
        // that is in Calendar that extends notification name
        // pass in this view controller so we can access the properties from it
        
        dismiss(animated: true)
    }
    
    var formattedDate: String {
        // getter for the dateformater object
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: datePicker.date)
    }
    
    var formattedTime: String {
        get { // can be deleted if there's no setter
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: datePicker.date)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if showTimePicker { // checks whether it should show time or Date
            titleLabel.text = "Select Time"
            datePicker.datePickerMode = .time
            saveButton.setTitle("Save Time", for: .normal)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(with:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        eventTitle.becomeFirstResponder()
        
    }
    
    @objc func keyboardWillShow(with notification: Notification) {
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else { return }
        
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    fileprivate func dismissAndResign() {
        dismiss(animated: true)
        eventTitle.resignFirstResponder()
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

extension DatePickViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        

        eventTitle.text.removeAll()
        eventDescription.text.removeAll()
        eventTitle.textColor = .gray
        eventDescription.textColor = .gray
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
