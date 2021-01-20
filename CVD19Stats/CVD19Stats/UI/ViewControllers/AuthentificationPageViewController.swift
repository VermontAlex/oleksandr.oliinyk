//
//  AuthentificationPageViewController.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 19.01.2021.
//

import UIKit
import Firebase


class AuthentificationPageViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements(){
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Authentification", bundle: nil)
        let signUpViewController = storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.signUpViewController) as! SignUpViewController
        self.present(signUpViewController, animated: true, completion: nil)
    }
    @IBAction func loginButton(_ sender: UIButton) {
    let storyboard: UIStoryboard = UIStoryboard(name: "Authentification", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.loginViewController) as! LoginViewController
    self.present(loginViewController, animated: true, completion: nil)
    }
    
}
