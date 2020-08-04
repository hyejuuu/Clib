//
//  PhraseEntity+CoreDataProperties.swift
//  
//
//  Created by 이혜주 on 2020/07/21.
//
//

import Foundation
import CoreData


extension PhraseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhraseEntity> {
        return NSFetchRequest<PhraseEntity>(entityName: "Phrase")
    }

    @NSManaged public var contents: String?
    @NSManaged public var itemId: String?
    @NSManaged public var page: String?
    @NSManaged public var imageUrl: String?

}
