//
//  Helpers.swift
//  Digimon
//
//  Created by Diggo Silva on 24/04/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
}

final class DSColor {
    static let primary   = color(r: 0, g: 154, b: 255, a: 1)
    static let secondary = color(r: 255, g: 215, b: 0, a: 1)
    static let secondaryText = color(r: 142, g: 142, b: 147, a: 1)
}

func color(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
}

