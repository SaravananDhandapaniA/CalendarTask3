//
//  CEOnBoardViewModel.swift
//  CalenderTask
//
//  Created by Tringapps on 23/06/22.
//

import Foundation
import UIKit

class CEOnBoardViewModel {
    
    var pageTitle = ["Calendar", "Custom Calendar Events", "Persist Events", "Custom Filter"]
    var pageSubTitle = [
        "A calendar is a system of organizing days. This is done by giving names to periods of time, typically days, weeks, months and years.",
        "Events are items that you'd like to put on your calendar that will in no way be tied to a priority.",
        "Calendars are useful tools for keeping track of upcoming meetings, deadlines, and milestones. They can help you visualize your schedule and remind you of important events, such as holidays and vacation time.",
        "Event filters give you a way to narrow down your event. You can limit event definitions to specific page, a specific domain, or a number of other options."
    ]
    
    var pageAnimation = ["LottieCalendar","LottieCustomCalendar","LottieEvents","LottieFilter"]
    
    var currentIndex = 0
}
