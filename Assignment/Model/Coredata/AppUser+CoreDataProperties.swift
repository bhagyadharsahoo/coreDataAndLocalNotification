//
//  AppUser+CoreDataProperties.swift
//  Assignment
//
//  Created by Bhagyadhar Sahoo on 22/06/25.
//
//

import Foundation
import CoreData


extension AppUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppUser> {
        return NSFetchRequest<AppUser>(entityName: "AppUser")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var userId: String?

}

extension AppUser : Identifiable {

}
