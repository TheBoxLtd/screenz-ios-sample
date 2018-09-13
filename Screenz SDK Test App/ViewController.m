//
//  ViewController.m
//  Screenz SDK Test App
//
//  Created by MC.
//  Copyright © 2018 Screenz. All rights reserved.
//

#import "ViewController.h"
#import <ScreenzSDK/ScreenzSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ScreenzSDKManager sharedInstance] loadInView:self.view viewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
