//
//  FeedView.swift
//  Digimon
//
//  Created by Diggo Silva on 24/04/25.
//

import UIKit

enum Section {
    case main
}

class FeedView: UIView {
    
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 14
        let widthScreen = (UIScreen.main.bounds.width) / 2.25
        
        layout.itemSize = CGSize(width: widthScreen, height: widthScreen * 1.5)
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.identifier)
        return cv
    }()
    
    lazy var bgSpinner: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        view.isHidden = true
        view.alpha = 0.25
        return view
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .label
        return spinner
    }()
    
    lazy var loadingLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .preferredFont(forTextStyle: .subheadline)
        lbl.textColor = .label
        lbl.textAlignment = .center
        lbl.text = "Carregando..."
        return lbl
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Digimon>!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .systemBackground
        addSubviews(collectionView, bgSpinner, spinner, loadingLabel)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            bgSpinner.topAnchor.constraint(equalTo: topAnchor),
            bgSpinner.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgSpinner.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgSpinner.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: bgSpinner.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: bgSpinner.centerYAnchor),
            
            loadingLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: padding),
            loadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            loadingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }
}
