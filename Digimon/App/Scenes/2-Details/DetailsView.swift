//
//  DetailsView.swift
//  Digimon
//
//  Created by Diggo Silva on 27/04/25.
//

import UIKit

class DetailsView: UIView {
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .red
        return img
    }()
    
    lazy var digiDescription: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .preferredFont(forTextStyle: .subheadline)
        lbl.numberOfLines = 8
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.75
        lbl.text = "A Reptile Digimon with an appearance resembling a small dinosaur, it has grown and become able to walk on two legs. Its strength is weak as it is still in the process of growing, but it has a fearless and rather ferocious personality. Hard, sharp claws grow from both its hands and feet, and their power is displayed in battle. It also foreshadows an evolution into a great and powerful Digimon. Its Special Move is spitting a fiery breath from its mouth to attack the opponent (Baby Flame)."
        return lbl
    }()
    
    lazy var priorTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .preferredFont(forTextStyle: .headline)
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.75
        lbl.text = "Anteriores"
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var nextTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .preferredFont(forTextStyle: .headline)
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.75
        lbl.text = "Próximos"
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var stackTitleCollection: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [priorTitle, nextTitle])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 16
        return sv
    }()
    
    lazy var priorCollection: UICollectionView = {
        let widthScreen = (UIScreen.main.bounds.width) / 2
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: widthScreen, height: widthScreen)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "priorCell")
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    lazy var nextCollection: UICollectionView = {
        let widthScreen = (UIScreen.main.bounds.width) / 2
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: widthScreen, height: widthScreen)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "nextCell")
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    lazy var stackCollection: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [priorCollection, nextCollection])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 16
        return sv
    }()
    
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
        addSubviews(imageView, digiDescription, stackTitleCollection, stackCollection)
        
    }
    
    private func setConstraints() {
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 220),
            imageView.heightAnchor.constraint(equalToConstant: 270),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            digiDescription.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding / 2),
            digiDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            digiDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            stackTitleCollection.topAnchor.constraint(equalTo: digiDescription.bottomAnchor, constant: padding / 2),
            stackTitleCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackTitleCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            stackTitleCollection.heightAnchor.constraint(equalToConstant: 30),
            
            stackCollection.topAnchor.constraint(equalTo: stackTitleCollection.bottomAnchor),
            stackCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            stackCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
