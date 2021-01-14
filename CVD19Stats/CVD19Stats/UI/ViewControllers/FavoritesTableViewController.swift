//
//  FavoritesTableViewController.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 14.01.2021.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    var favorites = [CovidStats]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("Error with cell!")
        }
        
        cell.countryStat.text = favorites[indexPath.row].country
        cell.casesStat.text = String(favorites[indexPath.row].cases)
        cell.deathStat.text = String(favorites[indexPath.row].deaths)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}


