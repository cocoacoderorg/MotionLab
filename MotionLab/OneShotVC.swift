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
    
    @IBAction func gestureRecognizer(_ sender: UIPanGestureRecognizer) {
        manipulable.center = sender.location(in: self.view);
        
        if (sender.state == .began) {
            let r = CGFloat(arc4random() % 100) / 100.0
            let g = CGFloat(arc4random() % 100) / 100.0
            let b = CGFloat(arc4random() % 100) / 100.0
            
            let newColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
            
            UIView.animate(withDuration: 2.0, animations: {
                self.manipulable.backgroundColor = newColor
            }) 
        }
        
    }


}

