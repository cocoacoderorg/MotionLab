//
//  ManipulablePhysicsVC.swift
//  MotionLab
//
//  Created by Drew Crawford on 8/20/14.
//  Copyright (c) 2014 DrewCrawfordApps. All rights reserved.
//

import UIKit

class ManipulablePhysicsVC: UIViewController {
    @IBOutlet var manipulable: UIView!
    var animator : UIDynamicAnimator? = nil;
    var dynamicBehavior : UIDynamicItemBehavior? = nil;
    var attachmentBehavior : UIAttachmentBehavior? = nil;
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: self.view)
        dynamicBehavior = UIDynamicItemBehavior(items: [manipulable])
        animator!.addBehavior(dynamicBehavior)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func gestureRecognizer(sender: UIPanGestureRecognizer) {
        switch(sender.state) {
        case .Began:
            let touchedLocationInManipulable = sender.locationInView(manipulable)
            let offset = UIOffsetMake(touchedLocationInManipulable.x - manipulable.bounds.size.width/2, touchedLocationInManipulable.y - manipulable.bounds.size.height/2);
            let touchedLocationInParent = sender.locationInView(self.view)
            attachmentBehavior = UIAttachmentBehavior(item: manipulable, offsetFromCenter: offset, attachedToAnchor: touchedLocationInParent)
            animator!.addBehavior(attachmentBehavior)

            
        case .Changed:
            var anchorPoint = attachmentBehavior!.anchorPoint
            var transform = sender.translationInView(self.view)
            anchorPoint.x += transform.x;
            anchorPoint.y += transform.y;
            attachmentBehavior!.anchorPoint = anchorPoint;
            sender.setTranslation(CGPointZero, inView: self.view)
            
        case .Ended:
            animator!.removeBehavior(attachmentBehavior)
            attachmentBehavior = nil;
            
        default:
            break;
            
        }
        
    }
}

