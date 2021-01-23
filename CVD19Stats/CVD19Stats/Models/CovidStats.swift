//
//  CovidStats.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 11.01.2021.
//

import Foundation


struct CovidStats: Codable {
    var country: String
    var countryInfo: CountryInfo
    var cases: Int
    var recovered: Int
    var deaths: Int
}

struct CountryInfo: Codable {
     var flag: String
}

extension CovidStats: Equatable{
    static func == (lhs: CovidStats, rhs: CovidStats) -> Bool {
        return lhs.country == rhs.country
            && lhs.cases == rhs.cases
            && lhs.recovered == rhs.recovered
    }
}



