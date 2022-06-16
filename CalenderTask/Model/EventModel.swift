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

struct EventData: Decodable, Encodable {
    let eventDataArray: [EventDataModel]
}

struct EventDataModel: Decodable, Encodable {
    let title: String?
    let date: String?
    let startTime: String?
    let endTime: String?
}
