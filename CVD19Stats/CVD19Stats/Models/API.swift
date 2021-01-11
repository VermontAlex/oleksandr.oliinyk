//
//  API.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 11.01.2021.
//

import Foundation


let url = "https://corona.lmao.ninja/v2/countries"

struct Response: Codable {
    let results: MyResult
    let status: String
}


struct MyResult: Codable {
    let country: String
    let cases: Int
    let deaths: Int
}



