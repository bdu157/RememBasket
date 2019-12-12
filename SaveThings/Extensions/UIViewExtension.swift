//
//  UIViewExtension.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 11/24/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setShadowandCornerRadius(scale:Bool = true) {
        layer.backgroundColor = UIColor.white.cgColor
        //        layer.borderWidth = 1.3
        //        layer.borderColor = UIColor.orange.cgColor
        
        //shadow
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
    }
    func shapeButtonsView() {
        //layer.backgroundColor = UIColor.white.cgColor
        //        layer.borderWidth = 1.3
        //        layer.borderColor = UIColor.orange.cgColor
        
        //shadow
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
    }
    
    func shapeSaveThingsButtonView() {
        layer.backgroundColor = #colorLiteral(red: 0.4904693301, green: 0.7448655672, blue: 0.9686274529, alpha: 1)
//        layer.borderWidth = 1.3
        
        //shadow
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 15
    }
    
    var image: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in layer.render(in: rendererContext.cgContext) }
    }
}

