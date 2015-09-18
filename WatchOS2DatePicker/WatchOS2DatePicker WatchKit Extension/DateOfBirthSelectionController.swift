//
//  DateOfBirthSelectionController.swift
//  WatchOS2DatePicker
//
//  Created by Hugo on 9/18/15.
//  Copyright © 2015 halonso. All rights reserved.
//

import WatchKit
import Foundation

protocol DateOfBirthSelectionControllerDelegate : class {
    func didSelectDateOfBirth(dateOfBirth: NSDate)
}


class DateOfBirthSelectionController: WKInterfaceController {
    
    @IBOutlet var dayPicker: WKInterfacePicker!
    @IBOutlet var monthPicker: WKInterfacePicker!
    @IBOutlet var yearPicker: WKInterfacePicker!
    
    static let maximumLifeSpan = 150
    
    weak var delegate: DateOfBirthSelectionControllerDelegate?
    
    var selectedMonth : Int = 0
    var selectedYear : Int = 0
    var selectedDay : Int = 0
    
    
    let months: [(String, Int)] = NSDate.getAllTreeDigitsMonthRepresentationForCurrentLocale()
    
    let years: [Int] = {
            let (_,_,year) = NSDate().dayMonthYear
            let maximumAge = year - maximumLifeSpan
            var _years = [Int]()
            for _year in maximumAge...year {
                _years.append(_year)
            }
            return _years
        }()
    
    
    var days: [Int] {
        get {
            let numberOfDays = NSDate.daysCountInMonth(selectedYear, month: selectedMonth)
            
            var _days = [Int]()
            
            for _day in  1...numberOfDays{
                _days.append(_day)
            }
            return _days
        }
    }
    
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.delegate = context as? DateOfBirthSelectionControllerDelegate
        
        let  (day, month, year) = NSDate().dayMonthYear
        
        selectedMonth = month - 1
        selectedYear = year
        selectedDay = day - 1
    }
    
    func calculateDays() {
        let pickerItems : [WKPickerItem] = days.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0.description
            pickerItem.caption = $0.description
            return pickerItem
        }
        dayPicker.setItems(pickerItems)
        if pickerItems.count - 1 < selectedDay {
            selectedDay = pickerItems.count - 1
        }
        dayPicker.setSelectedItemIndex(selectedDay)
    }
    
    func calculateMonths() {
        let pickerItems: [WKPickerItem] = months.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0.0
            pickerItem.caption = $0.1.description
            return pickerItem
        }
        monthPicker.setItems(pickerItems)
        monthPicker.setSelectedItemIndex(selectedMonth)
    }
    
    func calculateYears(){
        let pickerItems: [WKPickerItem] = years.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0.description
            pickerItem.caption = $0.description
            return pickerItem
        }
        yearPicker.setItems(pickerItems)
        let (_,_,year) = NSDate().dayMonthYear
        let index = years.count - (year - selectedYear) - 1
        yearPicker.setSelectedItemIndex(index)
    }
    
    override func willActivate() {
        super.willActivate()
        
        calculateMonths()
        calculateDays()
        calculateYears()
    }
    
    @IBAction func pickerSelectedMonthItemChanged(value: Int) {
        selectedMonth = Int(months[value].1)
        calculateDays()
    }
    @IBAction func pickerSelectedYearItemChanged(value: Int) {
        selectedYear = years[value]
        if selectedMonth == 2 {
            calculateDays()
        }
    }
    @IBAction func pickerSelectedDayItemChanged(value: Int) {
        selectedDay = value
    }
    
    @IBAction func doneTapped() {
        let selectedDate = NSDate.buildDateFor(selectedYear, month: selectedMonth , day: selectedDay + 1)
        delegate?.didSelectDateOfBirth(selectedDate)
        dismissController()
    }
}

