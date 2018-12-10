//
//  FavoritesFoodCoreData+CoreDataProperties.swift
//  RxFood
//
//  Created by Hira on 12/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoritesFoodCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesFoodCoreData> {
        return NSFetchRequest<FavoritesFoodCoreData>(entityName: "FavoritesFoodCoreData")
    }

    @NSManaged public var title: String?
    @NSManaged public var details: String?
    @NSManaged public var price: Int16
    @NSManaged public var imgaeUrl: String?
    @NSManaged public var users: UsersCoreData?

}
