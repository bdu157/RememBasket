//
//  UIButtonExtension.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 1/6/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func pulse() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 1000
        pulse.initialVelocity = 0.3
        pulse.damping = 1.3
        
        layer.add(pulse, forKey: nil)
    }
}
