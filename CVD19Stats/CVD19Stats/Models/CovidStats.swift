//
//  CovidStats.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 11.01.2021.
//

import Foundation


struct CovidStats: Codable {
    let country: String
    let countryInfo: CountryInfo
    let cases: Int
    let recovered: Int
    let deaths: Int
}

struct CountryInfo: Codable {
     let flag: String
}

extension CovidStats: Equatable{
    static func == (lhs: CovidStats, rhs: CovidStats) -> Bool {
        return lhs.country == rhs.country
            && lhs.cases == rhs.cases
            && lhs.recovered == rhs.recovered
    }
}


