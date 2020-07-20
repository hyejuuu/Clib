//
//  BookReport+CoreDataProperties.swift
//  
//
//  Created by 이혜주 on 2020/07/21.
//
//

import Foundation
import CoreData


extension BookReport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookReport> {
        return NSFetchRequest<BookReport>(entityName: "BookReport")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?

}
