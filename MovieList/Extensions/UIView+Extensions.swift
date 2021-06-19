//
//  UIView+Extensions.swift
//  MovieList
//
//  Created by cevhersirin on 16.06.2021.
//

import Foundation
import UIKit

extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func ownFirstNib() {
        let view = loadNib()
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
    }
    
    func dropShadow() {
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 5.0
        //layer.shouldRasterize = true
        layer.masksToBounds = false
    }
}
