//
//  SecondViewController.h
//  B Scanner
//
//  Created by Calvin Fernando on 4/18/14.
//  Copyright (c) 2014 Calvin Fernando. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController{
    
    IBOutlet UILabel *labell;
    IBOutlet UILabel *countIn;
    IBOutlet UIImageView *indicatorr;
    NSString *nihData;
    NSMutableArray *dataGua;
    NSString *hh;
    NSString *yoi;
    NSString *poi;
    NSUInteger k;
    int entered;
    NSString *enteredString;
}

@property NSString *myNewString;
@property (strong, nonatomic) IBOutlet UITextView *tvChat;

@end
