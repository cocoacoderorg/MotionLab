//
//  ColorBlend.swift
//  MotionLab
//
//  Created by Drew Crawford on 8/20/14.
//  Copyright (c) 2014 DrewCrawfordApps. All rights reserved.
//

import Foundation
import UIKit
func blend(_ c1: UIColor, c2: UIColor, alpha: CGFloat) -> UIColor {
    var alpha = alpha
    alpha = min(1.0, max(0, alpha))
    let beta = 1 - alpha;
    var r1 = CGFloat(0), g1 = CGFloat(0), b1 = CGFloat(0), a1 = CGFloat(0), r2 = CGFloat(0), g2 = CGFloat(0), b2 = CGFloat(0), a2 = CGFloat(0)
    
    c1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
    c2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
    let r = r1 * beta + r2 * alpha
    let g = g1 * beta + g2 * alpha
    let b = b1 * beta + b2 * alpha
    return UIColor(red: r, green: g, blue: b, alpha: 1)
    
    
}
