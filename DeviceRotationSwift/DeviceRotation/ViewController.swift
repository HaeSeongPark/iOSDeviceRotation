//
//  ViewController.swift
//  DeviceRotation
//
//  Created by rhino Q on 07/03/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    var orientationLast: UIInterfaceOrientation!
    var orientationAfterProcess: UIInterfaceOrientation!
    var motionManager:CMMotionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeMotionManager()
    }
    
    deinit {
        motionManager.stopAccelerometerUpdates()
    }
    
    
    func initializeMotionManager() {
        motionManager = CMMotionManager()
        motionManager.accelerometerUpdateInterval = 0.2;
        motionManager.gyroUpdateInterval = 0.2;
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (accelerometerData, error) in
            if error == nil {
                self.outputAccelertionData(accelerometerData!.acceleration)
            } else {
                if let error = error {
                    print("\(error)")
                }
            }
        }
    }
    
    func outputAccelertionData(_ acceleration: CMAcceleration) {
        var orientationNew: UIInterfaceOrientation?
        
        if acceleration.x >= 0.75 {
            orientationNew = .landscapeLeft
            print("Landscape Left")
        } else if acceleration.x <= -0.75 {
            orientationNew = .landscapeRight
            print("Landscape Right")
        } else if acceleration.y <= -0.75 {
            orientationNew = .portrait
            print("Portrait")
        } else {
            // Consider same as last time
            return
        }
        
        if orientationNew == orientationLast {
            return
        }
        
        orientationLast = orientationNew
    }
}

