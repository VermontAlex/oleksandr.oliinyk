//
//  HomeViewController.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 11.01.2021.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var covidTable: UITableView!
    
    
    var covidStats = [CovidStats]()
    
    
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
        let settingsViewController = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidTable.backgroundColor = .blue
        covidTable.delegate = self
        covidTable.dataSource = self
        downloadJSON {
            self.covidTable.reloadData()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covidStats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CovidStatsCellIdentifier"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("Error with cell!")
        }
        
        
        cell.countryStat.text = covidStats[indexPath.row].country
        cell.casesStat.text = String(covidStats[indexPath.row].cases)
        cell.deathStat.text = String(covidStats[indexPath.row].deaths)
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    
    
}





extension HomeScreenViewController {
    
    func downloadJSON(completed: @escaping () -> () ) {
        let url = URL(string: "https://corona.lmao.ninja/v2/countries")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do {
                self.covidStats = try JSONDecoder().decode([CovidStats].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("JSON error")
                }
        }
        }.resume()
        
        
        
        
        
    }
    
    
    
}
