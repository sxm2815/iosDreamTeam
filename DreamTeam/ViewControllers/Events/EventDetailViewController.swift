//
//  EventDetailViewController.swift
//  DreamTeam
//
//  Created by Student on 12/17/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var dateText = ""
    var descText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        dateLabel.text = dateText
        descLabel.text = descText
        descLabel.numberOfLines = 0
        // Do any additional setup after loading the view.
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
