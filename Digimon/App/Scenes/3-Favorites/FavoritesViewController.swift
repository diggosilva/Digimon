//
//  FavoritesViewController.swift
//  Digimon
//
//  Created by Diggo Silva on 07/05/25.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let favoritesView = FavoritesView()
    
    override func loadView() {
        super.loadView()
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureDelegatesAndDataSources()
    }
    
    private func configureNavBar() {
        title = "Favoritos"
    }
    
    private func configureDelegatesAndDataSources() {
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.identifier, for: indexPath) as? FavoritesCell else { return UITableViewCell() }
        
        return cell
    }
}
