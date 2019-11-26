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
        layer.cornerRadius = 15
        layer.borderWidth = 0.4
        layer.borderColor = UIColor.orange.cgColor
        textColor = UIColor.black
    }
    
    
    func addLeftImage(image: UIImage) {
        
        let leftImageView = UIImageView(frame: CGRect(x: 10.0, y: 5.0, width:20.0, height: 20.0))
        leftImageView.image = image
        leftImageView.tintColor = UIColor.orange
        
        let iconContainerView : UIView = UIView(frame: CGRect(x: 10, y: 0, width: 40, height: 30))
        iconContainerView.addSubview(leftImageView)
        
        leftView = iconContainerView
        leftViewMode = .always
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    func addShowandHidePasswordButton() {
        
    }
}
