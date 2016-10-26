//
//  AttractorVC.swift
//  MotionLab
//
//  Created by Drew Crawford on 8/20/14.
//  Copyright (c) 2014 DrewCrawfordApps. All rights reserved.
//


import UIKit

class AttractorVC: UIViewController {
    @IBOutlet var manipulable: UIView!
    
    @IBOutlet weak var m1: UIView!
    @IBOutlet weak var m2: UIView!
    @IBOutlet weak var m3: UIView!
    var animator : UIDynamicAnimator? = nil;
    var gravityBehavior : UIGravityBehavior? = nil;
    var collisionBehavior :UICollisionBehavior? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: self.view)
        
        gravityBehavior = UIGravityBehavior(items: [m1,m2,m3])
        animator?.addBehavior(gravityBehavior!)
        
        collisionBehavior = UICollisionBehavior(items: [m1,m2,m3])
        collisionBehavior?.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0))
        animator?.addBehavior(collisionBehavior!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func gestureRecognizer(_ sender: UIPanGestureRecognizer) {
        manipulable.center = sender.location(in: self.view)
        switch(sender.state) {
            
        case .changed:
            gravityBehavior?.gravityDirection = CGVector(dx: (manipulable.center.x - self.view.center.x) / self.view.center.x, dy: (manipulable.center.y - self.view.center.y) / self.view.center.y)
            
            
            
        default:
            break;
            
        }
        
    }
}

