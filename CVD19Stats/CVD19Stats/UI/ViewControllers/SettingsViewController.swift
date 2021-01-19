//
//  SettingsViewController.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 11.01.2021.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
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

