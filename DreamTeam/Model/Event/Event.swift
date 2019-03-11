//
//  Event.swift
//  DreamTeam
//
//  Created by Student on 12/17/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Event {
    var key: String
    var title: String
    var desc: String
    var date: String
    
    init(dictionary: [String: AnyObject], key: String) {
        self.key = key
        self.title = dictionary["Title"] as? String ?? ""
        self.desc = dictionary["Description"] as? String ?? ""
        self.date = dictionary["Date"] as? String ?? ""
    }
}
