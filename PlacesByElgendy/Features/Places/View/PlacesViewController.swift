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
    private let LoadingCellIdentifier = "LoadingCell"
    private var shouldShowLoadingCell = false
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
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCellIdentifier)
        tableView.isHidden = true
    }
}


// MARK: - UITableViewDelegate Methods
extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowLoadingCell {
            return viewModel.numberOfItems() + 1
        }
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isLoadingCell(for: indexPath) {
            return LoadingCell(style: .default, reuseIdentifier: LoadingCellIdentifier)
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? PlacesTableViewCell else {
                return   UITableViewCell()
            }
            cell.configure(with: viewModel.venue(at: indexPath.row))
            return cell
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadingCell(for: indexPath) {
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
    func onFetchCompleted(shouldShowLoadingCell: Bool) {
        activityIndicator.stopAnimating()
        self.shouldShowLoadingCell = shouldShowLoadingCell
        tableView.isHidden = false
        tableView.reloadData()
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
        guard shouldShowLoadingCell else { return false }
        return indexPath.row == viewModel.numberOfItems()
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
