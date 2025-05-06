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
    
    lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        return rc
    }()
    
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
        cv.refreshControl = refreshControl
        return cv
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Digimon>!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func setRefreshTarget(_ target: Any?, action: Selector) {
        refreshControl.addTarget(target, action: action, for: .valueChanged)
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .systemBackground
        addSubviews(collectionView)
    }
    
    private func setConstraints() {        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
