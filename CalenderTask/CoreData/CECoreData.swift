//
//  CECoreData.swift
//  CalenderTask
//
//  Created by Tringapps on 01/07/22.
//

import Foundation
import CoreData


class DataStore: NSObject {
    
    let persistence = CEPersistanceService.shared
    
    private override init() {
        super.init()
    }
    
    static let shared = DataStore()
    
    func request<T: NSManagedObject>(_ type:T.Type) {
        
    }
    
}
