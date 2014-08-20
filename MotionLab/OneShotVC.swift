//
//  FirstViewController.swift
//  MotionLab
//
//  Created by Drew Crawford on 8/20/14.
//  Copyright (c) 2014 DrewCrawfordApps. All rights reserved.
//

import UIKit

class OneShotVC: UIViewController {
                            
    @IBOutlet weak var manipulable: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func gestureRecognizer(sender: UIPanGestureRecognizer) {
        manipulable.center = sender.locationInView(self.view);
        
        if (sender.state == .Began) {
            let r = CGFloat(arc4random() % 100) / 100.0
            let g = CGFloat(arc4random() % 100) / 100.0
            let b = CGFloat(arc4random() % 100) / 100.0
            
            let newColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
            
            UIView.animateWithDuration(2.0) {
                self.manipulable.layer.backgroundColor = newColor.CGColor
            }
        }
        
    }


}

