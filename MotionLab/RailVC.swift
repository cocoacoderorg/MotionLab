//
//  RailVC.swift
//  MotionLab
//
//  Created by Drew Crawford on 8/20/14.
//  Copyright (c) 2014 DrewCrawfordApps. All rights reserved.
//

import Foundation
import UIKit
class RailVC: UIViewController {
    @IBOutlet weak var railCar: UIView!
    @IBOutlet weak var rail: UIView!
    
    var animator : UIDynamicAnimator? = nil
    var railCarBehavior : UIDynamicItemBehavior? = nil
    
    var leftSpring : UIAttachmentBehavior? = nil
    
    var initialRailCarCenter : CGPoint? = nil
    
    var gravity : UIGravityBehavior? = nil
    
    override  func viewDidLoad() {
        animator = UIDynamicAnimator(referenceView: self.view)
        initialRailCarCenter = self.view.convertPoint(railCar.center, fromView: rail)
    }
    
    @IBAction func gestureRecognizer(sender: UIPanGestureRecognizer) {
        railCar.center.x = sender.locationInView(rail).x
        if (sender.state == .Began) {
            animator?.removeAllBehaviors()
        }
        if (sender.state == .Ended) {
            
            //forbid rotation
            railCarBehavior = UIDynamicItemBehavior(items: [railCar!])
            railCarBehavior?.allowsRotation = false;
            
            //velocity match
            var velocity = sender.velocityInView(rail)
            velocity.y = 0
            railCarBehavior?.addLinearVelocity(velocity, forItem: railCar)
            
            animator?.addBehavior(railCarBehavior)
            
            //left spring
            leftSpring = UIAttachmentBehavior(item: railCar, offsetFromCenter: UIOffsetMake(0, 0), attachedToAnchor: initialRailCarCenter!)
            leftSpring?.length = 0
            leftSpring?.damping = 1.0
            leftSpring?.frequency = 8.0
            
            //gravity
            gravity = UIGravityBehavior(items: [railCar!])
            gravity?.gravityDirection = CGVectorMake(1.0, 0)
            
            let escaping = (railCar.center.x > self.view.center.x && railCarBehavior?.linearVelocityForItem(railCar).x > 0)
            if (escaping) {
                animator?.addBehavior(gravity)
                
                
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC))
                
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    self.railCar.center = self.rail.convertPoint(self.initialRailCarCenter!, fromView: self.view)
                    self.animator?.removeAllBehaviors()
                })
  
                
            }
            else {
                animator?.addBehavior(leftSpring)
            }
            
        }
    }
}