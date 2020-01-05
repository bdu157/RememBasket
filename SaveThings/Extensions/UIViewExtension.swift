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
        
        //shadow
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
    }
    
    func shapeSaveThingsButtonView() {
        layer.backgroundColor = UIColor.clear.cgColor

        //shadow
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 15
    }
    
    func shapeButtonsViewInUpdateView() {
        
        layer.backgroundColor = UIColor.orange.cgColor
        //shadow
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
    }
    
    var image: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in layer.render(in: rendererContext.cgContext) }
    }
    
    func shakeTextView() {
           
           let shake = CABasicAnimation(keyPath: "position")
           shake.duration = 0.1
           shake.repeatCount = 2
           shake.autoreverses = true
           
           let fromPoint = CGPoint(x: center.x - 5, y: center.y)
           let fromValue = NSValue(cgPoint: fromPoint)
           
           let toPoint = CGPoint(x: center.x + 5, y: center.y)
           let toValue = NSValue(cgPoint: toPoint)
           
           shake.fromValue = fromValue
           shake.toValue = toValue
           
           layer.add(shake, forKey: nil)
       }
}

