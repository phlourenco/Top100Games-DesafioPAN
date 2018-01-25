//
//  Game+CoreDataProperties.swift
//  GamesBancoPAN
//
//  Created by Paulo Lourenço on 24/01/18.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var name: String?
    @NSManaged public var viewers: Int32
    @NSManaged public var channels: Int32
    @NSManaged public var largeImage: NSData?
    @NSManaged public var mediumImage: NSData?

}
