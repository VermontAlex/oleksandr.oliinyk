//
//  DetailsViewController.swift
//  CVD19Stats
//
//  Created by Oleksandr Oliynyk on 12.01.2021.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var totalNumLabel: UILabel!
    @IBOutlet weak var recoveredNumLabel: UILabel!
    @IBOutlet weak var deadNumLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    var countryDetails: CovidStats?
    let favoritesButtonIcon = UIImage(named: "Star")
    let favoritesButtonIconFilled = UIImage(named: "StarFilled")
    
    
    
    @IBAction func addToFavoritesAction(_ sender: UIButton) {
        
        var favorites: [String] = UserDefaults.standard.stringArray(forKey: "Favorites") ?? []
        
        if countryDetails?.favorite ?? false {
//            favoritesButton.setImage(favoritesButtonIcon, for: .normal)
            //remove from favorites
            if let index = favorites.firstIndex(of: countryDetails!.country) {
                favorites.remove(at: index)
                print("Deleted")
            }
        }else{
//            favoritesButton.setImage(favoritesButtonIconFilled, for: .normal)
            //add to favorites
            favorites.append(countryDetails!.country)
            countryDetails?.favorite = true
            print("Added")
        }
        UserDefaults.standard.set(favorites, forKey: "Favorites")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryNameLabel.text = countryDetails?.country
        totalNumLabel.text = "\(countryDetails?.cases ?? 0)"
        recoveredNumLabel.text = "\(countryDetails?.recovered ?? 0)"
        deadNumLabel.text = "\(countryDetails?.deaths ?? 0)"
        flagImage.downloaded(from: (countryDetails?.countryInfo.flag)!)
        
//        if countryDetails?.favorite == true {
//            favoritesButton.setImage(favoritesButtonIconFilled, for: .normal)
//        }else{
//            favoritesButton.setImage(favoritesButtonIcon, for: .normal)
//        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
