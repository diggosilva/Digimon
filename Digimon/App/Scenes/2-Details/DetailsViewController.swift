//
//  DetailsViewController.swift
//  Digimon
//
//  Created by Diggo Silva on 27/04/25.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var viewModel: DetailsViewModelProtocol
    
    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationBar() {
        title = viewModel.getDetailsDigimon().name.uppercased()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(favoriteTapped))
    }
    
    @objc private func favoriteTapped() {
        print("Adicionou aos favoritos o digimon: \(viewModel.getDetailsDigimon().name)")
    }
}
