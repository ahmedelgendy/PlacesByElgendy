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
    private let cellIdentifier = "PlacesTableViewCell"
    
    init(viewModel: PlacesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.fetchPlaces()
    }
}

// MARK: - setup UI
extension PlacesViewController {
    func setupUI() {
        title = "Mekanlar"
        setupTableView()
        setupActivityIdicator()
    }
    
    func setupActivityIdicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    func setupTableView() {
        let nibName = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: cellIdentifier)
        tableView.prefetchDataSource = self
        tableView.isHidden = true
    }
}


// MARK: - UITableViewDelegate Methods
extension PlacesViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalItemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? PlacesTableViewCell else {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let provider = FourSquareProvider(network: Networking())
        let placeId = viewModel.venue(at: indexPath.row).id
        let detailsViewModel = PlaceDetailsViewModel(placeId: placeId, provider: provider)
        let detailsViewController = PlaceDetailsViewController(viewModel: detailsViewModel)
        detailsViewController.modalPresentationStyle = .overCurrentContext
        detailsViewController.modalTransitionStyle = .crossDissolve
        present(detailsViewController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - PlacesViewModelDelegate
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

// MARK: - Helper methods
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
