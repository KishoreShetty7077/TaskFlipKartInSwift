//
//  MacthesListViewController.swift
//  TaskFlipKartSwift
//
//  Created by Kishore B on 12/6/24.
//

import UIKit


class MatchesListViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: MatchesListViewModel!

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Initialization
    static func instantiate(with viewModel: MatchesListViewModel) -> MatchesListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MatchesListViewController") as? MatchesListViewController else {
            fatalError("MatchesListViewController not found in Main.storyboard")
        }
        controller.viewModel = viewModel
        return controller
    }


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        registerCells()
        reloadData()
    }

    // MARK: - UI Setup
    private func setupUI() {
        navigationItem.title = viewModel.getPlayerName(by: viewModel.player.id)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func registerCells() {
        tableView.register(UINib(nibName: "MatchesDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "MatchesDetailsTableViewCell")
    }

    // MARK: - Data Handling
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MatchesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Matches"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredMatches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchesDetailsTableViewCell", for: indexPath) as? MatchesDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        let match = viewModel.filteredMatches[indexPath.row]
        let cellData = viewModel.configureCell(for: match)
        
        cell.configure(with: cellData)
        return cell
    }
}
