//
//  BooksToReadEntity+CoreDataProperties.swift
//  
//
//  Created by 이혜주 on 2020/08/03.
//
//

import Foundation
import CoreData


extension BooksToReadEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BooksToReadEntity> {
        return NSFetchRequest<BooksToReadEntity>(entityName: "BooksToRead")
    }

    @NSManaged public var itemId: String?

}
