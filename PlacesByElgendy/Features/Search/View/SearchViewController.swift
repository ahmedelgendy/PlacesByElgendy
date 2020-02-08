//
//  SearchViewController.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 7.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        var city = "istanbul"
        if let searchText = searchTextField.text, !searchText.isEmpty {
            city = searchText
        }
        let provider = FourSquareProvider(network: Networking())
        let viewModel = PlacesViewModel(city: city, provider: provider)
        let placesViewController = PlacesViewController(viewModel: viewModel)
        navigationController?.pushViewController(placesViewController, animated: true)
    }
    

}

// MARK: - UI Setup
extension SearchViewController {
    private func setupUI() {
        // TODO: custom title font type ans size
        title = "Anasyafa" //TODO: localize
        view.backgroundColor = .viewBackground
        setupSearchTextField()
        setupSearchButton()
    }
    
    private func setupSearchTextField() {
        searchTextField.placeholder = "şehir giriniz" //TODO: localize
        searchTextField.layer.borderColor = UIColor.buttonBorder.cgColor
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.cornerRadius = 5
        searchTextField.backgroundColor = .white
        searchTextField.clipsToBounds = true
        //TODO: localize
        let placeholder = NSAttributedString(string: "Şehir giriniz", attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFieldPlaceholder])
        searchTextField.attributedPlaceholder = placeholder
        
        searchTextField.addShadow()
    }
    
    private func setupSearchButton() {
        searchButton.setTitle(title: "Ara") //TODO: localize
        searchButton.backgroundColor = .buttonBackground
        searchButton.tintColor = .white
        searchButton.layer.cornerRadius = 8
        searchButton.clipsToBounds = true
    }
}

