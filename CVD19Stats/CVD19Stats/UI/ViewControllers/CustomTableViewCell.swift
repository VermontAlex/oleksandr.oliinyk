//
//  CustomTableViewCell.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 11.01.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CovidStatsCellIdentifier"
    
    @IBOutlet weak var deathStat: UILabel!
    @IBOutlet weak var casesStat: UILabel!
    @IBOutlet weak var countryStat: UILabel!
    
    func fillCell(stats: CovidStats) {
        
        countryStat.text = stats.country
        casesStat.text = String(stats.cases)
        deathStat.text = String(stats.deaths)
    }
    
}
