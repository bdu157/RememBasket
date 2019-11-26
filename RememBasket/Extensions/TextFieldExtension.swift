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
        layer.cornerRadius = 8
        layer.borderWidth = 0.4
        layer.borderColor = UIColor.orange.cgColor
    }
    
    
    func addLeftImage(image: UIImage) {
        
        let leftImageView = UIImageView(frame: CGRect(x: 10.0, y: 5.0, width:20.0, height: 20.0))
        leftImageView.image = image
        
        let iconContainerView : UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(leftImageView)
        
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    func addShowandHidePasswordButton() {
        
    }
}
