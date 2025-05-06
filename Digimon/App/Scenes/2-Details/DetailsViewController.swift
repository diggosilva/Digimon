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
        handleStates()
        viewModel.fetchDetails()
    }
    
    private func configureNavigationBar() {
        title = viewModel.getDetailsDigimon().name.uppercased()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(favoriteTapped))
    }
    
    @objc private func favoriteTapped() {
        print("Adicionou aos favoritos o digimon: \(viewModel.getDetailsDigimon().name)")
    }
    
    private func handleStates() {
        viewModel.observeState { state in
            switch state {
            case .loading:
                self.showLoadingState()
                
            case .loaded(let details):
                self.showLoadedState(details: details)
                
            case .error:
                self.showErrorState()
            }
        }
    }
    
    private func showLoadingState() {}
    
    private func showLoadedState(details: Details) {
        detailsView.configure(details: details)
    }
    
    private func showErrorState() {
        presentDSAlert(title: "Ops, algo deu errado!", message: DSError.digimonsFailed.rawValue)
    }
}
