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
        configureDataSource()
        viewModel.setDelegate(self)
    }
    
    private func configureDataSource() {
        favoritesView.dataSource = FavoritesDiffableDataSource(tableView: favoritesView.tableView, cellProvider: { (tableView, indexPath, digimon) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.identifier, for: indexPath) as? FavoritesCell else { return UITableViewCell() }
            cell.configure(digimon: digimon)
            return cell
        })
    }
    
    private func updateData(on digimons: [Digimon]) {
        var snapshot = NSDiffableDataSourceSnapshot<FavoritesSection, Digimon>()
        snapshot.appendSections([.main])
        snapshot.appendItems(digimons)
        
        DispatchQueue.main.async {
            self.favoritesView.tableView.layoutIfNeeded() // Força a tabela a recalcular o layout
            self.favoritesView.dataSource.apply(snapshot, animatingDifferences: true)
        }
        setNeedsUpdateContentUnavailableConfiguration()
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

class FavoritesDiffableDataSource: UITableViewDiffableDataSource<FavoritesSection, Digimon> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let digimon = viewModel.cellForRow(at: indexPath)
        let detailsVC = DetailsViewController(viewModel: DetailsViewModel(digimon: digimon))
        
        guard let url = URL(string: digimon.image) else { return }
        
        detailsVC.detailsView.imageView.sd_setImage(with: url)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Deletar") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            
            // Obtém o digimon a ser removido
            let digimonToRemove = self.viewModel.cellForRow(at: indexPath)
            
            // Remove o digimon do ViewModel
            self.viewModel.removeDigimon(at: indexPath.row)
            self.viewModel.saveDigimons()
            
            // Atualiza o snapshot incrementalmente
            var snapshot = self.favoritesView.dataSource.snapshot()
            snapshot.deleteItems([digimonToRemove])
            self.favoritesView.dataSource.apply(snapshot, animatingDifferences: true)
            
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension FavoritesViewController: FavoritesViewModelDelegate {
    func reloadTable() {
        updateData(on: viewModel.getDigimons())
    }
}
