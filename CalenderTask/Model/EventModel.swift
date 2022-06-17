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
    let eventDataArray: [EventDataModel]
}

struct EventDataModel: Decodable {
    let title: String?
    let date: String?
    let startTime: String?
    let endTime: String?
}
