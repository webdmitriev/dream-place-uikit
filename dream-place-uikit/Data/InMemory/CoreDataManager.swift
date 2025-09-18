//
//  CoreDataManager.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 18.09.2025.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BookingModel")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: Save
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Core Data Save Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: Add to favorite
    func addFavorite(booking: Booking) {
        let request: NSFetchRequest<FavoriteBooking> = FavoriteBooking.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", booking.id)
        
        if let result = try? context.fetch(request), !result.isEmpty {
            print("⚠️ Уже в избранном")
            return
        }
        
        let favorite = FavoriteBooking(context: context)
        favorite.id = Int16(booking.id)
        favorite.name = booking.name
        favorite.address = booking.addressShort
        favorite.price = Int16(booking.price ?? 0)
        favorite.image = booking.image ?? ""
        favorite.rating = booking.rating ?? 0
        saveContext()
    }
    
    // MARK: Remove from favorite
    func removeFavorite(id: Int) {
        let request: NSFetchRequest<FavoriteBooking> = FavoriteBooking.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        if let result = try? context.fetch(request), let objectToDelete = result.first {
            context.delete(objectToDelete)
            saveContext()
        }
    }
    
    // MARK: is Favorite
    func isFavorite(id: Int) -> Bool {
        let request: NSFetchRequest<FavoriteBooking> = FavoriteBooking.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        let count = (try? context.count(for: request)) ?? 0
        return count > 0
    }
    
    // MARK: fetch all favorite
    func fetchFavorites() -> [FavoriteBooking] {
        let request: NSFetchRequest<FavoriteBooking> = FavoriteBooking.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
}
