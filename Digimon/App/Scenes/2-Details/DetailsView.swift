//
//  DetailsView.swift
//  Digimon
//
//  Created by Diggo Silva on 27/04/25.
//

import UIKit
import SDWebImage

class DetailsView: UIView {
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 10
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.lightGray.cgColor
        img.backgroundColor = .white
        return img
    }()
    
    lazy var digiDescription: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .preferredFont(forTextStyle: .subheadline)
        lbl.numberOfLines = 0
        return lbl
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
    
    func configure(details: Details) {
        digiDescription.text = details.digiDescriptions
    }
    
    private func setHierarchy() {
        backgroundColor = .systemBackground
        addSubviews(imageView, digiDescription)
        
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
        ])
    }
}
