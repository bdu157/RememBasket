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
}
