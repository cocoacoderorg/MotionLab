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
        animator!.addBehavior(dynamicBehavior!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func gestureRecognizer(_ sender: UIPanGestureRecognizer) {
        switch(sender.state) {
        case .began:
            let touchedLocationInManipulable = sender.location(in: manipulable)
            let offset = UIOffsetMake(touchedLocationInManipulable.x - manipulable.bounds.size.width/2, touchedLocationInManipulable.y - manipulable.bounds.size.height/2);
            let touchedLocationInParent = sender.location(in: self.view)
            attachmentBehavior = UIAttachmentBehavior(item: manipulable, offsetFromCenter: offset, attachedToAnchor: touchedLocationInParent)
            animator!.addBehavior(attachmentBehavior!)

            
        case .changed:
            var anchorPoint = attachmentBehavior!.anchorPoint
            let transform = sender.translation(in: self.view)
            anchorPoint.x += transform.x;
            anchorPoint.y += transform.y;
            attachmentBehavior!.anchorPoint = anchorPoint;
            sender.setTranslation(CGPoint.zero, in: self.view)
            
        case .ended:
            animator!.removeBehavior(attachmentBehavior!)
            attachmentBehavior = nil;
            
        default:
            break;
            
        }
        
    }
}

