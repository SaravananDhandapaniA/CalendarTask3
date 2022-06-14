//
//  EventViewModel.swift
//  CalenderTask
//
//  Created by Tringapps on 13/06/22.
//

import Foundation
import UIKit

class EventViewModel {
    
    var eventItem = [EventModel(about: "Input", list: ["title","Date"]),
                     EventModel(about: "TimeIntervel", list: ["startTime","endTime"])]
    
    func numberOfRowsInSection(section: Int) -> Int {
        return eventItem[section].list.count
    }
    func cellForRowAt(indexPath: IndexPath) -> EventModel {
        return eventItem[indexPath.section]
    }
    func numberOfSections(tableView: UITableView) -> Int {
        return eventItem.count
    }
    func titleForHeaderInSection(section: Int) -> String {
        return eventItem[section].about
    }
}

