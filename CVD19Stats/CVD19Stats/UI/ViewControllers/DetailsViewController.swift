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
    var didPushFavorites: ((CovidStats) -> ())?
    var isFavorite: Bool = false

    @IBAction func addToFavoritesAction(_ sender: UIButton) {
        guard let countryDetails = countryDetails else { return }
        isFavorite.toggle()
        changeStarFill()
        didPushFavorites?(countryDetails)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        countryNameLabel.text = countryDetails?.country
        totalNumLabel.text = "\(countryDetails?.cases ?? 0)"
        recoveredNumLabel.text = "\(countryDetails?.recovered ?? 0)"
        deadNumLabel.text = "\(countryDetails?.deaths ?? 0)"
        flagImage.downloaded(from: (countryDetails?.countryInfo.flag)!)
        changeStarFill()
        overrideUserInterfaceStyle = .light
    }
    
    private func changeStarFill(){
        let image = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favoritesButton.setImage(image, for: .normal)
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
