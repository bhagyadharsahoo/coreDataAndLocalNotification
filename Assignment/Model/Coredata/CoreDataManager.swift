//
//  CoreDataManager.swift
//  Assignment
//
//  Created by Bhagyadhar Sahoo on 22/06/25.
//

import Foundation
import CoreData
import UIKit
import UserNotifications

final class CoreDataManager {
    static let shared = CoreDataManager()
    var notificationsEnabled = true
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveItem(id: String, name: String, data: DataClass) {
        let items = fetchItems()
        if !items.isEmpty {
            return
        }
        
        let item = PhoneData(context: context)
        item.id = id
        item.name = name
        item.dataColor = data.dataColor
        item.dataCapacity = data.dataCapacity
        item.dataPrice = data.dataPrice ?? 0.0
        item.dataGeneration = data.dataGeneration
        item.year = Int16(data.year ?? 0)
        item.cpuModel = data.cpuModel
        item.hardDiskSize = data.hardDiskSize
        item.strapColour = data.strapColour
        item.caseSize = data.caseSize
        item.color = data.color
        item.descriptionNew = data.descriptionNew
        item.capacity = data.capacity
        item.screenSize = data.screenSize ?? 0.0
        item.generation = data.generation
        item.price = data.price
        
        saveContext()
        context.refresh(item, mergeChanges: true)
    }
    
    func fetchItems() -> [PhoneData] {
        let request: NSFetchRequest<PhoneData> = PhoneData.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func updateItem(_ item: PhoneData, newName: String) {
        item.name = newName
        saveContext()
    }
    
    func deleteItem(_ item: PhoneData) {
        let deletedName = item.name ?? "Unnamed Item"
        context.delete(item)
        saveContext()
    
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            if notificationsEnabled {
                checkNotificationStatus { isEnabled in
                    if isEnabled {
                        let content = UNMutableNotificationContent()
                        content.title = "Item Deleted"
                        content.body = "You deleted: \(deletedName)"
                        content.sound = .default
                        
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                    } else {
                        self.notificationsEnabled = false
                        let alert = UIAlertController(
                            title: "Notifications Disabled",
                            message: "Please enable notifications in Settings to get important updates.",
                            preferredStyle: .alert
                        )
                        
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        alert.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: { _ in
                            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(settingsURL)
                            }
                        }))
                        
                        if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                            rootVC.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Core Data Save Error: \(error.localizedDescription)")
        }
    }
    
    func checkNotificationStatus(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus == .authorized)
            }
        }
    }
}
