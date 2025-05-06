//
//  FeedViewController.swift
//  Digimon
//
//  Created by Diggo Silva on 20/04/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    let feedView = FeedView()
    let viewModel: FeedViewModelProtocol = FeedViewModel()
    
    override func loadView() {
        super.loadView()
        view = feedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleRefresh()
        configNavBarAndDelegatesAndDataSources()
        handleStates()
        viewModel.fetchDigimons()
    }
    
    private func handleRefresh() {
        feedView.setRefreshTarget(self, action: #selector(didPullToRefresh))
    }
    
    @objc private func didPullToRefresh() {
        viewModel.fetchDigimons()
    }
    
    private func handleStates() {
        viewModel.observeState { state in
            switch state {
            case .loading: self.showLoadingState()
            case .loaded: self.showLoadedState()
            case .error: self.showErrorState()
            }
        }
    }
    
    private func showLoadingState() {}
    
    private func showLoadedState() {
        updateData(on: viewModel.getDigimons())
        if feedView.collectionView.refreshControl?.isRefreshing == true {
            feedView.collectionView.refreshControl?.endRefreshing()
        }
        feedView.collectionView.reloadData()
    }
    
    private func showErrorState() {
        presentDSAlert(title: "Ops... algo deu errado!", message: DSError.networkError.rawValue)
    }
    
    private func configNavBarAndDelegatesAndDataSources() {
        configureNavBar()
        configureDelegates()
        configureDataSource()
    }
    
    private func configureNavBar() {
        title = "Digimon"
    }
    
    private func configureDelegates() {
        feedView.collectionView.delegate = self
    }
    
    private func configureDataSource() {
        feedView.dataSource = UICollectionViewDiffableDataSource<Section, Digimon>(collectionView: feedView.collectionView, cellProvider: { (collectionView, indexPath, digimon) -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell else { return UICollectionViewCell() }
            cell.configure(digimon: digimon)
            return cell
        })
    }
    
    private func updateData(on digimons: [Digimon]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Digimon>()
        snapshot.appendSections([.main])
        snapshot.appendItems(digimons)
        DispatchQueue.main.async {
            self.feedView.dataSource.apply(snapshot, animatingDifferences: true)
        }
        setNeedsUpdateContentUnavailableConfiguration()
    }
}

extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let digimon = viewModel.cellForItem(at: indexPath)
        let detailsVC = DetailsViewController(viewModel: DetailsViewModel(digimon: digimon))
        
        guard let url = URL(string: digimon.image) else { return }
        detailsVC.detailsView.imageView.sd_setImage(with: url)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
