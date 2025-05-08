//
//  FavoritesCell.swift
//  Digimon
//
//  Created by Diggo Silva on 07/05/25.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    static let identifier = "FavoritesCell"
    
    lazy var digiImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "person.circle")
        iv.layer.cornerRadius = 25
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Digimon Name"
        lbl.font = .preferredFont(forTextStyle: .headline)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        addSubviews(digiImageView, nameLabel)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            digiImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            digiImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            digiImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            digiImageView.widthAnchor.constraint(equalToConstant: 50),
            digiImageView.heightAnchor.constraint(equalTo: digiImageView.widthAnchor),
            
            nameLabel.centerYAnchor.constraint(equalTo: digiImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: digiImageView.trailingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }
}
