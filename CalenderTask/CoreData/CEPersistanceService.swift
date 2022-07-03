//
//  CEPersistanceService.swift
//  CalenderTask
//
//  Created by Tringapps on 01/07/22.
//

import Foundation
import CoreData

class CEPersistanceService {
    
    private init() {}
    static let shared = CEPersistanceService()
    
    var context: NSManagedObjectContext{ return persistentContainer.viewContext}

    lazy var persistentContainer: NSPersistentContainer = {
      
        let container = NSPersistentContainer(name: "CECoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Saved SuccessFully")
                print(context)
                NotificationCenter.default.post(name: NSNotification.Name("PersistedDataUpdated"), object: nil)
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ type:T.Type, completion: @escaping ([T]) -> Void) {
        
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        
        do{
            let objects = try context.fetch(request)
            completion(objects)
        }
        catch{
            print(error)
            completion([])
        }
    }
}
