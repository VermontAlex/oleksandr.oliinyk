//
//  HomeViewController.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 11.01.2021.
//

import UIKit



class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var covidTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    
    
    var covidStats = [CovidStats]()
    var filtered    = [CovidStats]()
    
    
    
    @IBAction func favorites(_ sender: UIBarButtonItem) {
        let favoritesTableViewController = storyboard?.instantiateViewController(identifier: "FavoritesTableViewController") as! FavoritesTableViewController
        navigationController?.pushViewController(favoritesTableViewController, animated: true)
        
    }
    
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
        let settingsViewController = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(settingsViewController, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSON {
        self.filtered = self.covidStats
        self.covidTable.reloadData()
        }
        searchBar.showsCancelButton = true
        searchBar.delegate          = self
        covidTable.delegate = self
        covidTable.dataSource = self
        
    }
    
    
    func someMethodIWantToCall(){
        print("Im here")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("Error with cell!")
        }
        cell.fillCell(stats: self.filtered[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        
        detailsViewController.countryDetails = filtered[indexPath.row]
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

extension HomeScreenViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String ) {
        debugPrint(searchText)
        guard !searchText.isEmpty else {
            filtered = covidStats
            covidTable.reloadData()
            return
        }
        filtered = covidStats.filter({ covidStats -> Bool in
            covidStats.country.lowercased().contains(searchText.lowercased())
        })
        covidTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filtered = covidStats
        covidTable.reloadData()
    }
}
