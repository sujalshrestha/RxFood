//
//  UsersCoreData+CoreDataProperties.swift
//  RxFood
//
//  Created by Hira on 12/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//
//

import Foundation
import CoreData


extension UsersCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UsersCoreData> {
        return NSFetchRequest<UsersCoreData>(entityName: "UsersCoreData")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstname: String?
    @NSManaged public var lastname: String?
    @NSManaged public var userid: Int16
    @NSManaged public var foods: NSSet?

}

// MARK: Generated accessors for foods
extension UsersCoreData {

    @objc(addFoodsObject:)
    @NSManaged public func addToFoods(_ value: FavoritesFoodCoreData)

    @objc(removeFoodsObject:)
    @NSManaged public func removeFromFoods(_ value: FavoritesFoodCoreData)

    @objc(addFoods:)
    @NSManaged public func addToFoods(_ values: NSSet)

    @objc(removeFoods:)
    @NSManaged public func removeFromFoods(_ values: NSSet)

}
