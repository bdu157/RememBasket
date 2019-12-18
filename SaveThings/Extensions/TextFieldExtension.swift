//
//  TextFieldExtension.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 11/25/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func shapeTextField() {
        
        layer.cornerRadius = 18
        layer.borderWidth = 0.4
        backgroundColor = .white
        tintColor = .orange
        textColor = .black
        
        //shadow
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    //Adding Left Image
    func addLeftImage(image: UIImage) {
        
        let leftImageView = UIImageView(frame: CGRect(x: 10.0, y: 5.0, width:20.0, height: 20.0))
        leftImageView.image = image
        leftImageView.tintColor = UIColor.orange
        
        let iconContainerView : UIView = UIView(frame: CGRect(x: 10.0, y: 0, width: 40, height: 30))
        iconContainerView.addSubview(leftImageView)
        
        leftView = iconContainerView
        leftViewMode = .always
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }

    //TextField animaion when required fields are missing
    func shake() {
        
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
