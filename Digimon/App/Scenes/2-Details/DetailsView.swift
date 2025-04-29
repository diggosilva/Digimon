//
//  DetailsView.swift
//  Digimon
//
//  Created by Diggo Silva on 27/04/25.
//

import UIKit

class DetailsView: UIView {
    
    
    
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
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
