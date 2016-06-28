//
//  UIView+Extension.swift
//  Freddy
//
//  Created by Sonam Dhingra on 6/28/16.
//  Copyright © 2016 Sonam Dhingra. All rights reserved.
//

import UIKit
import QuartzCore

extension UIView {

    func pulse() {
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 0.8
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 0.8
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = FLT_MAX
        layer.addAnimation(pulseAnimation, forKey: "pulseAimation")
    }
}