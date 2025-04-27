//
//  Helpers.swift
//  Digimon
//
//  Created by Diggo Silva on 24/04/25.
//

import UIKit

//MARK: EXTENSION VIEW
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
}

//MARK: EXTENSION VIEW CONTROLLER
extension UIViewController {
    func presentDSAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alert.addAction(ok)
        present(alert, animated: true)
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
