//
//  RailVC.swift
//  MotionLab
//
//  Created by Drew Crawford on 8/20/14.
//  Copyright (c) 2014 DrewCrawfordApps. All rights reserved.
//

import Foundation
import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

class RailVC: UIViewController {
    @IBOutlet weak var railCar: UIView!
    @IBOutlet weak var rail: UIView!
    
    var animator : UIDynamicAnimator? = nil
    var railCarBehavior : UIDynamicItemBehavior? = nil
    
    var leftSpring : UIAttachmentBehavior? = nil
    
    var initialRailCarCenter : CGPoint? = nil
    
    var gravity : UIGravityBehavior? = nil
    
    var UUID = Foundation.UUID()
    
    override  func viewDidLoad() {
        animator = UIDynamicAnimator(referenceView: self.view)
        initialRailCarCenter = self.view.convert(railCar.center, from: rail)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
    }
    
    @IBAction func gestureRecognizer(_ sender: UIPanGestureRecognizer) {
        railCar.center.x = sender.location(in: rail).x
        if (sender.state == .began) {
            animator?.removeAllBehaviors()
            UUID=Foundation.UUID()
        }
        if (sender.state == .ended) {
            //forbid rotation
            railCarBehavior = UIDynamicItemBehavior(items: [railCar!])
            railCarBehavior?.allowsRotation = false;
            
            //velocity match
            var velocity = sender.velocity(in: rail)
            velocity.y = 0
            railCarBehavior?.addLinearVelocity(velocity, for: railCar)
            
            animator?.addBehavior(railCarBehavior!)
            
            //left spring
            leftSpring = UIAttachmentBehavior(item: railCar, offsetFromCenter: UIOffsetMake(0, 0), attachedToAnchor: initialRailCarCenter!)
            leftSpring?.length = 0
            leftSpring?.damping = 1.0
            leftSpring?.frequency = 8.0
            
            //gravity
            gravity = UIGravityBehavior(items: [railCar!])
            gravity?.gravityDirection = CGVector(dx: 1.0, dy: 0)
            
            let escaping = (railCar.center.x > self.view.center.x && railCarBehavior?.linearVelocity(for: railCar).x > 0)
            if (escaping) {
                animator?.addBehavior(gravity!)
                
                let time = DispatchTime.now() + Double(Int64(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
                let current_UUID=self.UUID
                DispatchQueue.main.asyncAfter(deadline: time, execute: { () -> Void in
                    if (current_UUID != self.UUID) { return }
                    self.railCar.center = self.rail.convert(self.initialRailCarCenter!, from: self.view)
                    self.animator?.removeAllBehaviors()
                })
            }
            else {
                animator?.addBehavior(leftSpring!)
            }
            
        }
    }
}
