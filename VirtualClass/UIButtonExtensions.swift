//
//  UIButtonExtensions.swift
//  VirtualClass
//
//  Created by Alperen Aysel on 30.11.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        
        pulse.duration = 1
        pulse.fromValue = 1.10
        pulse.toValue = 1
        pulse.autoreverses = false
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.8
        pulse.damping = 3.0
        layer.add(pulse, forKey: nil)
    }
    func coverTheScreen() {
        
        let cover = CASpringAnimation(keyPath: "transform.scale")
        
        cover.duration = 1
        cover.fromValue = 1
        cover.toValue = 15
        cover.autoreverses = false
        cover.repeatCount = 0
      
        layer.add(cover, forKey: nil)
    }

}
