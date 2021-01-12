//
//  DetailsViewController.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 12.01.2021.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var totalNumLabel: UILabel!
    @IBOutlet weak var recoveredNumLabel: UILabel!
    @IBOutlet weak var deadNumLabel: UILabel!
    
    
    var countryDetails: CovidStats?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        countryNameLabel.text = countryDetails?.country
        totalNumLabel.text = "\(countryDetails?.cases ?? 0)"
        recoveredNumLabel.text = "\(countryDetails?.recovered ?? 0)"
        deadNumLabel.text = "\(countryDetails?.deaths ?? 0)"
        
        
    }
    
    
    
        
        
        
    
    
    


}
