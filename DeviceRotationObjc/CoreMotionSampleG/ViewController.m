//
//  ViewController.m
//  CoreMotionSampleG
//
//  Created by Glenn on 11/25/15.
//  Copyright © 2015 GlennPosadas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIInterfaceOrientation orientationLast, orientationAfterProcess;
    CMMotionManager *motionManager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"viewDidLoad");
    self.view.backgroundColor = [UIColor blueColor];
    
    [self initializeMotionManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeMotionManager{
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = .2;
    motionManager.gyroUpdateInterval = .2;
    
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                        withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                            if (!error) {
                                                [self outputAccelertionData:accelerometerData.acceleration];
                                            }
                                            else{
                                                NSLog(@"%@", error);
                                            }
                                        }];
}

- (void)outputAccelertionData:(CMAcceleration)acceleration{
    UIInterfaceOrientation orientationNew;
    
    if (acceleration.x >= 0.75) {
        orientationNew = UIInterfaceOrientationLandscapeLeft;
        NSLog(@"Landscape Left");
    }
    else if (acceleration.x <= -0.75) {
        orientationNew = UIInterfaceOrientationLandscapeRight;
        NSLog(@"Landscape Right");
    }
    else if (acceleration.y <= -0.75) {
        orientationNew = UIInterfaceOrientationPortrait;
        NSLog(@"Portrait");
    }
//    else if (acceleration.y >= 0.75) {
//        orientationNew = UIInterfaceOrientationPortraitUpsideDown;
//    }
    else {
        // Consider same as last time
        return;
    }
    
    if (orientationNew == orientationLast)
        return;
    
    orientationLast = orientationNew;
}

- (void)dealloc
{
    //TODO: Stop MotionManager
    [motionManager stopAccelerometerUpdates];
}


@end
