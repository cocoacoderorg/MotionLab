//
//  ProjectileVC.swift
//  MotionLab
//
//  Created by Drew Crawford on 8/20/14.
//  Copyright (c) 2014 DrewCrawfordApps. All rights reserved.
//

import UIKit

class ProjectileVC: UIViewController {
    
    var animator : UIDynamicAnimator? = nil
    var dynamicItemBehavior : UIDynamicItemBehavior? = nil
    var projectile : UIView? = nil
    var collisionBehavior : UICollisionBehavior? = nil
    
    override func viewDidLoad() {
        animator = UIDynamicAnimator(referenceView: self.view)
        collisionBehavior = UICollisionBehavior()
        animator?.addBehavior(collisionBehavior)
        collisionBehavior?.translatesReferenceBoundsIntoBoundary = true;
    }

    @IBAction func gestureRecognizer(sender: UIPanGestureRecognizer) {
        switch(sender.state) {
        case .Began:
            let location = sender.locationInView(self.view)
            projectile = UIView(frame: CGRect(origin: CGPointZero, size: CGSizeMake(20, 20)))
            projectile?.center = location
            projectile?.backgroundColor = UIColor.redColor()
            self.view.addSubview(projectile!)
        
        case .Changed:
            let location = sender.locationInView(self.view)
            projectile?.center = location
        
        case .Ended:
            let velocity = sender.velocityInView(self.view)
            
            dynamicItemBehavior = UIDynamicItemBehavior(items:[projectile!])
            dynamicItemBehavior?.addLinearVelocity(velocity, forItem: projectile)
            animator?.addBehavior(dynamicItemBehavior)
            collisionBehavior?.addItem(projectile)
            
            
        default:
            break
        }
    }
}
