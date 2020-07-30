//
//  BookReportEntiry+CoreDataProperties.swift
//  
//
//  Created by 이혜주 on 2020/07/21.
//
//

import Foundation
import CoreData


extension BookReportEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookReportEntiry> {
        return NSFetchRequest<BookReportEntity>(entityName: "BookReport")
    }

    @NSManaged public var contents: String?
    @NSManaged public var isbn: String?
    @NSManaged public var title: String?
    @NSManaged public var rate: Float?

}
