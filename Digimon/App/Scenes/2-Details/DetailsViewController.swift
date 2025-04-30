//
//  DetailsViewController.swift
//  Digimon
//
//  Created by Diggo Silva on 27/04/25.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let detailsView = DetailsView()
    let viewModel: DetailsViewModelProtocol
    
    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        super.loadView()
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureDelegatesAndDataSources()
    }
    
    private func configureNavigationBar() {
        title = viewModel.getDetailsDigimon().name.uppercased()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(favoriteTapped))
    }
    
    @objc private func favoriteTapped() {
        print("Adicionou aos favoritos o digimon: \(viewModel.getDetailsDigimon().name)")
    }
    
    private func configureDelegatesAndDataSources() {
        detailsView.priorCollection.delegate = self
        detailsView.priorCollection.dataSource = self
        detailsView.nextCollection.delegate = self
        detailsView.nextCollection.dataSource = self
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == detailsView.priorCollection {
            return 3
        } else if collectionView == detailsView.nextCollection {
            return 6
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == detailsView.priorCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "priorCell", for: indexPath)
            cell.backgroundColor = .brown
            return cell
        } else if collectionView == detailsView.nextCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nextCell", for: indexPath)
            cell.backgroundColor = .cyan
            return cell
        }
        return UICollectionViewCell()
    }
}
