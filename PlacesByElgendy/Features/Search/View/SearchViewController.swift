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
        view.endEditing(true)
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
        title = "Anasyafa"
        view.backgroundColor = .viewBackground
        setupSearchTextField()
        setupSearchButton()
    }
    
    private func setupSearchTextField() {
        searchTextField.placeholder = "şehir giriniz"
        searchTextField.layer.borderColor = UIColor.buttonBorder.cgColor
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.cornerRadius = 5
        searchTextField.backgroundColor = .white
        searchTextField.clipsToBounds = true
        let placeholder = NSAttributedString(string: "Şehir giriniz", attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFieldPlaceholder])
        searchTextField.attributedPlaceholder = placeholder
        searchTextField.delegate = self
        searchTextField.addShadow()
    }
    
    private func setupSearchButton() {
        searchButton.setTitle(title: "Ara")
        searchButton.backgroundColor = .buttonBackground
        searchButton.tintColor = .white
        searchButton.layer.cornerRadius = 8
        searchButton.clipsToBounds = true
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == searchTextField {
            if string.count > 0 {
                var allowedCharacters = CharacterSet.letters
                allowedCharacters.insert(charactersIn: " ")
                let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
                return unwantedStr.count == 0
            }
        }
        
        return true
    }
}


