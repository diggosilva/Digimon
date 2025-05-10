//
//  FavoritesViewController.swift
//  Digimon
//
//  Created by Diggo Silva on 07/05/25.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let favoritesView = FavoritesView()
    private let viewModel: FavoritesViewModelProtocol
    
    init(viewModel: FavoritesViewModelProtocol = FavoritesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        super.loadView()
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureDelegatesAndDataSources()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadDigimons()
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
    private func configureNavBar() {
        title = "Favoritos"
    }
    
    private func configureDelegatesAndDataSources() {
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
        viewModel.setDelegate(self)
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if viewModel.numberOfRowsInSection() == 0 {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "star")
            config.text = "Sem Favoritos ainda"
            config.secondaryText = "Sua lista de Digimons favoritos aparecerá aqui."
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.identifier, for: indexPath) as? FavoritesCell else { return UITableViewCell() }
        let digimon = viewModel.cellForRow(at: indexPath)
        cell.configure(digimon: digimon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let digimon = viewModel.cellForRow(at: indexPath)
        let detailsVC = DetailsViewController(viewModel: DetailsViewModel(digimon: digimon))
        
        guard let url = URL(string: digimon.image) else { return }
        
        detailsVC.detailsView.imageView.sd_setImage(with: url)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeDigimon(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            viewModel.saveDigimons()
            setNeedsUpdateContentUnavailableConfiguration()
        }
    }
}

extension FavoritesViewController: FavoritesViewModelDelegate {
    func reloadTable() {
        favoritesView.tableView.reloadData()
    }
}
