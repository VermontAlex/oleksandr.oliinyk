//
//  HomeViewController.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 11.01.2021.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var covidTable: UITableView!
    
    
    
    
    
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
        let settingsViewController = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidTable.backgroundColor = .blue
        getData(from: url)
        covidTable.delegate = self
        covidTable.dataSource = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CovidStatsCellIdentifier"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("Error with cell!")
        }
        
        
        cell.countryStat.text = "Ukraine"
        cell.casesStat.text = "10"
        cell.deathStat.text   = "90"
        
        
        
        
        return cell
    }
    
    
    
}





extension HomeScreenViewController {
    
    private func getData(from url: String) {
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                print("something was wrong")
                return
            }
            
        // Have data
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print("failed to convert \(error.localizedDescription)")
            }
            guard let json = result else { return }
            
            print(json.status)
            
            
            
        })
        
    }
    
    
    
}
