//
//  Utilities.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 19.01.2021.
//

import Foundation
import UIKit

class Utilities {
    static func styleTextField(_ textField: UITextField){
        //Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: 300, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 99/255, blue: 173/255, alpha: 1).cgColor
        
        //Remove border on text field
        textField.borderStyle = .none
        
        //Add the line to the text field
        textField.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(_ button: UIButton) {
        //Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 48/255, green: 99/255, blue: 173/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button: UIButton) {
        //Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
