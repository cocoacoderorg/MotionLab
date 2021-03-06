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
        animator?.addBehavior(collisionBehavior!)
        collisionBehavior?.translatesReferenceBoundsIntoBoundary = true;
    }

    @IBAction func gestureRecognizer(_ sender: UIPanGestureRecognizer) {
        switch(sender.state) {
        case .began:
            let location = sender.location(in: self.view)
            projectile = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20)))
            projectile?.center = location
            projectile?.backgroundColor = UIColor.red
            self.view.addSubview(projectile!)
        
        case .changed:
            let location = sender.location(in: self.view)
            projectile?.center = location
        
        case .ended:
            let velocity = sender.velocity(in: self.view)
            
            dynamicItemBehavior = UIDynamicItemBehavior(items:[projectile!])
            dynamicItemBehavior?.addLinearVelocity(velocity, for: projectile!)
            animator?.addBehavior(dynamicItemBehavior!)
            collisionBehavior?.addItem(projectile!)
            
            
        default:
            break
        }
    }
}
