//
//  CovidCountry+CoreDataProperties.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 23.01.2021.
//
//

import Foundation
import CoreData


extension CovidCountry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CovidCountry> {
        return NSFetchRequest<CovidCountry>(entityName: "CovidCountry")
    }

    @NSManaged public var covidcases: Int64
    @NSManaged public var coviddeaths: Int64
    @NSManaged public var covidnamecountry: String?
    @NSManaged public var covidrecovered: Int64
    @NSManaged public var covidflag: CovidFlag?

}

extension CovidCountry : Identifiable {

}
