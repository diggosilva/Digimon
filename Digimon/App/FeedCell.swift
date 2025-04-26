//
//  FeedCell.swift
//  Digimon
//
//  Created by Diggo Silva on 24/04/25.
//

import UIKit
import SDWebImage

class FeedCell: UICollectionViewCell {
    
    static let identifier = "FeedCell"
    
    lazy var digiImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 8
        iv.layer.borderWidth = 1
        iv.layer.borderColor = DSColor.primary.cgColor
        return iv
    }()
    
    lazy var digiName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = .preferredFont(forTextStyle: .headline)
        lbl.textColor = DSColor.primary
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setupCell()
        setHierarchy()
        setConstraints()
    }
    
    func configure(digimon: Digimon) {
        guard let url = URL(string: digimon.image) else { return }
        
        digiImage.sd_setImage(with: url)
        digiName.text = digimon.name
    }
    
    private func setupCell() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setHierarchy() {
        addSubviews(digiImage, digiName)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            digiImage.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            digiImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            digiImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            digiImage.bottomAnchor.constraint(equalTo: digiName.topAnchor, constant: -padding),
            
            digiName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            digiName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            digiName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
}
