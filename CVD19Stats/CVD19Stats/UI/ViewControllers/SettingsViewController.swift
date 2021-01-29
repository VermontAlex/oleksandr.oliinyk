//
//  SettingsViewController.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 11.01.2021.
//

import UIKit
import Firebase
import CoreData


class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func removeAllFavorites(_ sender: UIButton) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CovidCountry")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do{
            try context.execute(deleteRequest)
        } catch {
            print("Error due to Removing all data")
        }
    }
    
    @IBAction func logOutAction(_ sender: UIButton) {
        do {
          try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
}
