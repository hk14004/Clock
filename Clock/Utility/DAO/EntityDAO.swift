//
//  EntityDAO.swift
//  Clock
//
//  Created by Hardijs on 09/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit
import CoreData

class EntityDAO<T: NSManagedObject> {
    
    weak var delegate: NSFetchedResultsControllerDelegate? {
        didSet {
            fetchedController?.delegate = delegate
        }
    }
    
    private(set) var persistentConatiner: NSPersistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    private(set) var fetchedController: NSFetchedResultsController<T>? {
        didSet {
             fetchedController?.delegate = delegate
        }
    }
    
    func save() {
        try! persistentConatiner.viewContext.save()
    }
    
    func loadData(requestModifier: ((NSFetchRequest<T>) -> Void)? = nil ) -> [T] {
        // Default request
        let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: T.entity().name!)
        request.sortDescriptors = []
        
        // Modify request if necessary
        requestModifier?(request)
        
        // Perform fetch
        fetchedController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: persistentConatiner.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        try! fetchedController?.performFetch()
        
        return fetchedController?.fetchedObjects ?? []
    }
    
    // TODO: Add try block
    func delete(at: IndexPath) {
        guard let toBeDeleted = fetchedController?.fetchedObjects?[at.row] else {
            return
        }
        persistentConatiner.viewContext.delete(toBeDeleted)
        save()
    }
    
    func delete(_ toBeDeleted: [T]) {
        toBeDeleted.forEach {persistentConatiner.viewContext.delete($0)}
        save()
    }
    
    func createEntity(entityModifier: (T) -> Void) {
        let new = T(context: persistentConatiner.viewContext)
        entityModifier(new)
        save()
    }
}
