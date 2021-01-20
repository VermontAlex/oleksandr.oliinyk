//
//  HomeViewController.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 11.01.2021.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var flagIconOutlet: UIImageView!
    @IBOutlet weak var covidTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favoritesOutletButton: UIBarButtonItem!
    
    var covidStats = [CovidStats]()
    private var filtered  = [CovidStats]()
    private var favorites = [CovidStats]()
    private var shouldShowFavorites = false
    static let identifier = "HomeScreenViewController"
    
    
    @IBAction func favorites(_ sender: UIBarButtonItem) {
        favoritesOutletButton.image = !shouldShowFavorites ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        shouldShowFavorites.toggle()
        covidTable.reloadData()
    }
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
        let settingsViewController = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(settingsViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSON {
            self.covidTable.reloadData()
        }
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        covidTable.delegate = self
        covidTable.dataSource = self
        overrideUserInterfaceStyle = .light
    }
    
    func someMethodIWantToCall(){
        print("Im here")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayStats().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("Error with cell!")
        }
        let array = displayStats()
        cell.fillCell(stats: array[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        let array = displayStats()
        let stats = array[indexPath.row]
        detailsViewController.countryDetails = stats
        detailsViewController.isFavorite = favorites.contains(stats)
        detailsViewController.didPushFavorites = { [weak self] stats in
            self?.processFavorites(with: stats)
        }
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    private func displayStats() -> [CovidStats] {
        if shouldShowFavorites {
            return favorites
        } else if !filtered.isEmpty {
            return filtered
        } else {
           return covidStats
        }
    }
    private func processFavorites(with stats: CovidStats) {
        if let index = favorites.firstIndex(of: stats) {
            favorites.remove(at: index)
        } else {
            favorites.append(stats)
        }
        covidTable.reloadData()
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
        filtered = covidStats.filter({ covidStats -> Bool in
            covidStats.country.lowercased().contains(searchText.lowercased())
        })
        covidTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filtered.removeAll()
        covidTable.reloadData()
    }
}

