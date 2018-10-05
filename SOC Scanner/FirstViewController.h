//
//  FirstViewController.h
//  B Scanner
//
//  Created by Calvin Fernando on 4/18/14.
//  Copyright (c) 2014 Calvin Fernando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface FirstViewController : UIViewController {
    
    IBOutlet UIImageView *indicator;
}
@property NSMutableString *mCode;
@property AVCaptureSession *mCaptureSession;

@end
