//
//  CovidStats.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 11.01.2021.
//

import Foundation

struct CovidStats: Decodable {
    let country: String
    let flag: String
    let cases: Int
    let recovered: Int
    let deaths: Int
}

