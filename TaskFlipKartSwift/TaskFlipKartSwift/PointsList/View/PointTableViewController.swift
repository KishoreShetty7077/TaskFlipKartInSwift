//
//  PointListViewController.swift
//  TaskFlipKartSwift
//
//  Created by Kishore B on 12/6/24.
//

import UIKit


class PointListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let viewModel = PointListViewModel()
    private var loader: UIActivityIndicatorView?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchData()
        
        viewModel.didEncounterError = { [weak self] errorMessage in
            self?.showSnackbar(message: errorMessage)
        }
    }
    
    // MARK: - UI Setup
    private func setupTableView() {
        tableView.register(UINib(nibName: "PointsDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "PointsDetailsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Loader Methods
    private func showLoader() {
        loader = UIActivityIndicatorView(style: .gray)
        guard let loader = loader else { return }
        loader.center = view.center
        loader.startAnimating()
        view.addSubview(loader)
        tableView.isHidden = true
    }
    
    private func hideLoader() {
        loader?.stopAnimating()
        loader?.removeFromSuperview()
        tableView.isHidden = false
    }
    
    // MARK: - Data Fetching
    private func fetchData() {
        showLoader()
        viewModel.fetchData { [weak self] in
            self?.hideLoader()
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension PointListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Points Table"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pointsTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PointsDetailsTableViewCell", for: indexPath) as? PointsDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        let entry = viewModel.pointsTable[indexPath.row]
        cell.configure(with: entry)
        
        if let avatarUrl = URL(string: entry.player.icon) {
            ImageDownloderManager.shared.loadImage(from: avatarUrl) { image in
                DispatchQueue.main.async {
                    cell.userImage?.image = image
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = viewModel.pointsTable[indexPath.row]
        let matchesViewModel = MatchesListViewModel(player: entry.player, matches: viewModel.matches, players: viewModel.players)
        let matchesVC = MatchesListViewController.instantiate(with: matchesViewModel)
        navigationController?.pushViewController(matchesVC, animated: true)
    }
}
