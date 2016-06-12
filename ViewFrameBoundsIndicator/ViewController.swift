//
//  ViewController.swift
//  ViewFrameBoundsIndicator
//
//  Created by Naoyuki Takura on 2016/06/04.
//  Copyright © 2016年 Naoyuki Takura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var boundXSlider: UISlider!
    @IBOutlet weak var boundYSlider: UISlider!
    @IBOutlet weak var rotationSlider: UISlider!
    @IBOutlet weak var detailTextView: UITextView!
    
    var targetView: UIView!
    var targetSubView: UIImageView!
    var frameLayer: CALayer!
    var boundsLayer: CALayer!
    @IBOutlet weak var clipBoundsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        targetView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 200))
        targetView.center = CGPoint(x: view.frame.width / 2, y: 200)
        targetView.backgroundColor = UIColor.whiteColor()
        targetView.layer.contentsScale = UIScreen.mainScreen().scale
        targetView.clipsToBounds = true

        // sub sub view
        targetSubView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 200))
        targetSubView.image = UIImage(named: "C789_unitoikuramaguro_TP_V.jpg")
        targetSubView.contentMode = UIViewContentMode.TopLeft
        targetSubView.layer.contentsScale = UIScreen.mainScreen().scale

        // add to sub view
        targetView.addSubview(targetSubView)
        // add to superview
//        view.addSubview(targetView)
        view.insertSubview(targetView, atIndex: 0)
        
        // layer of indicating frame border line
        frameLayer = CALayer()
        frameLayer.frame = targetView.frame
        frameLayer.backgroundColor = UIColor.clearColor().CGColor
        frameLayer.borderColor = UIColor.blueColor().CGColor
        frameLayer.borderWidth = 2.0
        view.layer.addSublayer(frameLayer)
        
        // layer of indicating bounds border line
        boundsLayer = CALayer()
        boundsLayer.frame = targetView.bounds
        boundsLayer.backgroundColor = UIColor.clearColor().CGColor
        boundsLayer.borderColor = UIColor.greenColor().CGColor
        boundsLayer.borderWidth = 2.0
        targetView.layer.addSublayer(boundsLayer)
        
        // information
        detailTextView.text = "frame: \(targetView.frame)\nbounds: \(targetView.bounds)\ncenter: \(targetView.center)"
        
        print("targetView frame : \(targetView.frame)")
        print("targetView bounds: \(targetView.bounds)")
        print("targetView center: \(targetView.center)")
        
        // slider handler settings
        boundXSlider.addTarget(self, action: #selector(changeBoundsHandler), forControlEvents: UIControlEvents.ValueChanged)
        boundYSlider.addTarget(self, action: #selector(changeBoundsHandler), forControlEvents: UIControlEvents.ValueChanged)
        rotationSlider.addTarget(self, action: #selector(changeBoundsHandler), forControlEvents: UIControlEvents.ValueChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func changeBoundsHandler(sender: AnyObject) {

        if boundXSlider == sender as! NSObject {
            // x
            targetView.bounds.origin.x = (targetSubView.image!.size.width - targetView.bounds.width) * CGFloat(boundXSlider.value) / 2
            
        } else if boundYSlider == sender as! NSObject {
            // y
            targetView.bounds.origin.y = (targetSubView.image!.size.height - targetView.bounds.height) * CGFloat(boundYSlider.value) / 2
        } else if rotationSlider == sender as! NSObject {
            // rotation
            let transform = CGAffineTransformMakeRotation(2 * CGFloat(M_PI) * CGFloat(rotationSlider.value))
            targetView.transform = transform
        }
        // update layer of frame
        frameLayer.frame = targetView.frame
        boundsLayer.frame = targetView.bounds
        
        // information
        detailTextView.text = "frame: \(targetView.frame)\nbounds: \(targetView.bounds)\ncenter: \(targetView.center)"
        
    }
    
    @IBAction func changeSwitchHandler(sender: AnyObject) {
        targetView.clipsToBounds = clipBoundsSwitch.on
        
    }
    
}

