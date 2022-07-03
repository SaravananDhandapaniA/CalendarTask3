//
//  CalendarEvent+CoreDataProperties.swift
//  CalenderTask
//
//  Created by Tringapps on 02/07/22.
//
//

import Foundation
import CoreData


extension CalendarEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalendarEvent> {
        return NSFetchRequest<CalendarEvent>(entityName: "CalendarEvent")
    }

    @NSManaged public var color: String?
    @NSManaged public var date: String?
    @NSManaged public var endTime: String?
    @NSManaged public var eventType: String?
    @NSManaged public var location: String?
    @NSManaged public var repeatMode: String?
    @NSManaged public var startTime: String?
    @NSManaged public var title: String?

}

extension CalendarEvent : Identifiable {

}
