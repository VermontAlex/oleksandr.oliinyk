//
//  LoginViewController.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 19.01.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    static let identifier = "LoginViewController"

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        //MARK: Personall pre-fill login.
        #if DEBUG
        emailTextField.text = "test@test.com"
        passwordTextField.text = "Qwerty12!@"
        #endif
        overrideUserInterfaceStyle = .light
    }
    
    func setUpElements() {
        //Hide the error label
        errorLabel.alpha = 0
        
        //Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        //Create cleaned versions of the text
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                //Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                
                self.transitionToHome()
            }
        }
    }
    
    func transitionToHome() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(identifier: HomeScreenViewController.identifier) as? HomeScreenViewController {
            self.sceneDelegate?.show(controller)
        }
    }
}

extension UIViewController {
    var sceneDelegate: SceneDelegate? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return nil }
        return delegate
    }
}
