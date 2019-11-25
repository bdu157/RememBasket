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
    func setShadowandCornerRadius() {
        layer.backgroundColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.orange.cgColor
        layer.cornerRadius = 6.0
    }
}
