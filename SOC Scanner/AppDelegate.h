//
//  AppDelegate.h
//  B Scanner
//
//  Created by Calvin Fernando on 4/18/14.
//  Copyright (c) 2014 Calvin Fernando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MCManager *mcManager;

@property (copy, readwrite) NSString  *sharedString;

@end
