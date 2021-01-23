//
//  TestTableViewController.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 22.01.2021.
//

import UIKit

class TestTableViewController: UITableViewController {
    
    @IBOutlet weak var name: UILabel!
    
    private var covidFavCountry = [CovidCountry]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
  

    @IBAction func showCoreData(_ sender: UIButton) {
        fetchCountry()
        tableView.reloadData()
        print("Show CoreData tapped")
    }
    
    //RETRIEVE CorData
    func fetchCountry(){
        do {
            self.covidFavCountry = try context.fetch(CovidCountry.fetchRequest())
        } catch {
            print("Error in fetchCountry from HomeVC")
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return covidFavCountry.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let customer = self.covidFavCountry[indexPath.row]
        cell.textLabel?.text = customer.covidnamecountry
        
        return cell
    }


}
