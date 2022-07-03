//
//  CEEventModel.swift
//  CalenderTask
//
//  Created by Tringapps on 30/06/22.
//

import Foundation
import Lottie

struct CEEventModel: Decodable {
    var eventsArray:[CEEventData]
}

struct CEEventData: Decodable {
    var date : String?
    var title : String?
    var color : String?
    var eventType : String?
    var startTime : String?
    var endTime : String?
    var location : String?
    var repeatMode : String?
}
