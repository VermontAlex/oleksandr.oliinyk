//
//  SignUpViewController.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 19.01.2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        //Hide the error label
        errorLabel.alpha = 0
        
        //Style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    //Check the fields and validate that the data is correct. If everything is correct< this method returns nil. Otherwise< it returns the error message.
    func validateFields() -> String? {
        //Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {

            return "Please fill in all fields."
        }
        //Check if the email valid
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isEmailValid(cleanedEmail) == false {
            return "Make sure your email is contains a character @ and a hosting."
        }

        //Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Make sure your password is at least 8 characters contains a special character and a number."
        }
        return nil
    }

    @IBAction func signUpTapped(_ sender: UIButton) {
        //Validate fields
        let error = validateFields()
        if error != nil {
            //There was an error with the fields, show error message
            showError(error!)
        } else {
            //Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //Check for errors
                if err != nil {
                    // There was an error creating the user
                    self.showError("Error creating user")
                } else {
                    
                    //User was created succesfully, now store the firs name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstName": firstName, "lastName":lastName, "uid":result!.user.uid]) { (error) in
                        
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                    }
                    //Transition to he home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError(_ message: String)  {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome() {
        let homeScreenViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboards.homeScreenViewController) as? HomeScreenViewController
        view.window?.rootViewController = homeScreenViewController
        view.window?.makeKeyAndVisible()
    }
}

