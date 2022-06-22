//
//  EventModel.swift
//  CalenderTask
//
//  Created by Tringapps on 13/06/22.
//

import Foundation

struct EventModel {
    let about: String
    let list: [String]
}

struct EventData: Decodable {
    var eventDataArray: [EventDataModel]
}

struct EventDataModel: Decodable {
    var title: String?
    var date: String?
    var startTime: String?
    var endTime: String?
}
