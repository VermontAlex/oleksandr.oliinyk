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
    var favorite: Bool? 
}

struct CountryInfo: Codable {
     let flag: String
}


