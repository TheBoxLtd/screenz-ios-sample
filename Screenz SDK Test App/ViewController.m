//
//  ViewController.m
//  Screenz SDK Test App
//
//  Created by MC.
//  Copyright © 2018 Screenz. All rights reserved.
//

#import "ViewController.h"
#import <ScreenzSDK/ScreenzSDK.h>

@interface ViewController () <ScreenzSDKManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ScreenzSDKManager sharedInstance] loadInView:self.view viewController:self];
    [[ScreenzSDKManager sharedInstance] setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ScreenzSDKManagerDelegate_dataReceived:(NSString *)data {
    NSLog(@"RECEIVED data from Screenz: %@", data);
    if ([data isEqualToString:@"sdk-exit-new"]) { //Check if it's the "exit" event
        //    [self dismissViewControllerAnimated:YES completion:nil];
        // The above should be the right way for most cases, but due to that our example has only 1 VC, we just remove it
        [self.view removeFromSuperview];
    }
}

@end
