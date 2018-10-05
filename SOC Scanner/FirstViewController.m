//
//  FirstViewController.m
//  B Scanner
//
//  Created by Calvin Fernando on 4/18/14.
//  Copyright (c) 2014 Calvin Fernando. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation FirstViewController
@synthesize mCode,mCaptureSession;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    indicator.backgroundColor = [UIColor greenColor];
    indicator.hidden = YES;
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    mCaptureSession = [[AVCaptureSession alloc] init];
    
    AVCaptureDevice *videoCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoCaptureDevice error:&error];
    
    if ([mCaptureSession canAddInput:videoInput]) {
        [mCaptureSession addInput:videoInput];
    } else {
        NSLog(@"Could not add video input: %@", [error localizedDescription]);
    }
    
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    if ([mCaptureSession canAddOutput:metadataOutput]) {
        [mCaptureSession addOutput:metadataOutput];
        [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [metadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code]];
    } else {
        NSLog(@"Could not add metadata output.");
    }
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:mCaptureSession];
    previewLayer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:previewLayer];
    
    [mCaptureSession startRunning];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    // 1
    if (mCode == nil) {
        mCode = [[NSMutableString alloc] initWithString:@""];
    }
    
    // 2
    [mCode setString:@""];
    
    // 3
    for (AVMetadataObject *metadataObject in metadataObjects) {
        AVMetadataMachineReadableCodeObject *readableObject = (AVMetadataMachineReadableCodeObject *)metadataObject;
        
        // 4
        if([metadataObject.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            [mCode appendFormat:@"%@", readableObject.stringValue];
        }
    }
    
    // 5
    if (![mCode isEqualToString:@""]) {
        
        AppDelegate   *sharedData = (AppDelegate *)([[UIApplication sharedApplication]delegate]);
        sharedData.sharedString= mCode;
        
        NSLog(@"yg ke appdelegate %@",sharedData.sharedString);
        
        indicator.hidden=NO;
        
        if ([mCaptureSession isRunning])
            [mCaptureSession stopRunning];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([mCaptureSession isRunning] == NO)
        [mCaptureSession startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([mCaptureSession isRunning])
        [mCaptureSession stopRunning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
