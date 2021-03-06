//
//  PlacesViewController.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 7.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

class PlacesViewController: UIViewController, AlertDisplayer {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: PlacesViewModel!
    
    init(viewModel: PlacesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mekanlar"
        viewModel.delegate = self
        activityIndicator.hidesWhenStopped = true
        tableView.isHidden = true
        
        let nibName = UINib(nibName: "PlacesTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier:  "PlacesTableViewCell")
        tableView.prefetchDataSource = self
        activityIndicator.startAnimating()
        viewModel.fetchPlaces()
        
    }
    
    
}

// MARK: - UITableViewDelegate Methods

extension PlacesViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalItemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesTableViewCell") as? PlacesTableViewCell else {
            return UITableViewCell()
        }
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: viewModel.venue(at: indexPath.row))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchPlaces()
        }
    }
    
}


extension PlacesViewController: PlacesViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func onFetchFailed(with reason: String) {
        activityIndicator.stopAnimating()
        let title = "Hata"
        let action = UIAlertAction(title: "Tamam", style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
}




private extension PlacesViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.numberOfItems()
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
