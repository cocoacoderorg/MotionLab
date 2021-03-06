//
//  SecondViewController.swift
//  MotionLab
//
//  Created by Drew Crawford on 8/20/14.
//  Copyright (c) 2014 DrewCrawfordApps. All rights reserved.
//

import UIKit

class ProgressiveAnimationVC: UIViewController {
                            
    @IBOutlet var manipulable: UIView!
    
    func colorForProgress(_ progress: CGFloat) -> UIColor {
        let startColor = UIColor(red: 0.3, green: 0.5, blue: 0.8, alpha: 1.0)
        let endColor = UIColor(red: 0.5, green: 0.8, blue: 0.2, alpha: 1.0)
        let mixedColor = blend(startColor, c2: endColor, alpha: progress)
        return mixedColor;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manipulable.backgroundColor = colorForProgress(0.0)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func gestureRecognizer(_ sender: UIPanGestureRecognizer) {
        manipulable.center = sender.location(in: self.view);
        
        let progress = sender.location(in: self.view).y / self.view.bounds.height;
        manipulable.backgroundColor = colorForProgress(progress);
        
        
    }

}

