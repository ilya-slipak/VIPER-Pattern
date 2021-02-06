//
//  UIView+CircleCornerRadius.swift
//  Viper
//
//  Created by Ilya on 10/5/19.
//  Copyright © 2019 Ilya Slipak. All rights reserved.
//

import UIKit

extension UIView {
    
    func circleCornerRadius(height: CGFloat, width: CGFloat) {
        
        let minValue = min(height, width)
        let circleRadius = minValue / 2
        layer.cornerRadius = circleRadius
    }
}
