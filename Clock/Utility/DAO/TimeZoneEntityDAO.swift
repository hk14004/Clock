//
//  TimeZoneEntityDAO.swift
//  Clock
//
//  Created by Hardijs on 09/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit
import CoreData

class TimeZoneEntityDAO {
    
    weak var delegate: NSFetchedResultsControllerDelegate? {
        didSet {
            fetchedController?.delegate = delegate
        }
    }
    
    private(set) var persistentConatiner: NSPersistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    private(set) var fetchedController: NSFetchedResultsController<TimeZoneEntity>?
    
    func save() {
        try! persistentConatiner.viewContext.save()
    }
    
    func loadData(requestModifier: ((NSFetchRequest<TimeZoneEntity>) -> Void)? = nil ) -> [TimeZoneEntity] {
        // Default request
        let request: NSFetchRequest<TimeZoneEntity> = TimeZoneEntity.fetchRequest()
        request.sortDescriptors = []
        
        // Modify request if necessary
        requestModifier?(request)
        
        // Perform fetch
        fetchedController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: persistentConatiner.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        try! fetchedController?.performFetch()
        
        return fetchedController?.fetchedObjects ?? []
    }
    
    func delete(at: IndexPath) {
        guard let toBeDeleted = fetchedController?.fetchedObjects?[at.row] else {
            return
        }
        persistentConatiner.viewContext.delete(toBeDeleted)
        save()
    }
    
    func addTimezone(entityModifier: (TimeZoneEntity) -> Void) {
        let new = TimeZoneEntity(context: persistentConatiner.viewContext)
        entityModifier(new)
        save()
    }
}
