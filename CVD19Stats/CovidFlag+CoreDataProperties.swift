//
//  CovidFlag+CoreDataProperties.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 23.01.2021.
//
//

import Foundation
import CoreData


extension CovidFlag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CovidFlag> {
        return NSFetchRequest<CovidFlag>(entityName: "CovidFlag")
    }

    @NSManaged public var flagimage: String?
    @NSManaged public var countryrelationship: NSSet?

}

// MARK: Generated accessors for countryrelationship
extension CovidFlag {

    @objc(addCountryrelationshipObject:)
    @NSManaged public func addToCountryrelationship(_ value: CovidCountry)

    @objc(removeCountryrelationshipObject:)
    @NSManaged public func removeFromCountryrelationship(_ value: CovidCountry)

    @objc(addCountryrelationship:)
    @NSManaged public func addToCountryrelationship(_ values: NSSet)

    @objc(removeCountryrelationship:)
    @NSManaged public func removeFromCountryrelationship(_ values: NSSet)

}

extension CovidFlag : Identifiable {

}
