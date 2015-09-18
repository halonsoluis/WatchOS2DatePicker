//
//  InterfaceController.swift
//  WatchOS2DatePicker WatchKit Extension
//
//  Created by Hugo on 9/18/15.
//  Copyright © 2015 halonso. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    var selectedDate = NSDate()
    
    @IBOutlet var dateLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        updateShownDate(selectedDate)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func showDateOfBirthSelection() {
        presentControllerWithName("DateOfBirthSelectionController", context: self)
    }
    
    func updateShownDate(date: NSDate){
        let text = date.dateRepresentation()
        self.dateLabel.setText(text)
    }
}

extension InterfaceController: DateOfBirthSelectionControllerDelegate {
    func didSelectDateOfBirth(dateOfBirth: NSDate) {
         selectedDate = dateOfBirth
     }
}
