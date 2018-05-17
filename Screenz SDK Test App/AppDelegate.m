//
//  AppDelegate.m
//  Screenz SDK Test App
//
//  Created by MC.
//  Copyright © 2018 Screenz. All rights reserved.
//

#import "AppDelegate.h"
#import <ScreenzSDK/ScreenzSDK.h>

#define JSON_DATA @"config"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Initialize the SDK Manager shared instance
    ScreenzSDKManager* manager = [ScreenzSDKManager sharedInstance];
    [manager loadConfigurationFromJSONFile:JSON_DATA];
    /////
    
    //Set the view controller
    self.viewController = [[ScreenzSDKLoadingViewController alloc] initVC];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    if (launchOptions != nil) {
        NSDictionary *dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dictionary) {
            //TODO: notifications on launch app
        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"RECEIVE Remote notification %@",userInfo);
    
    [[ScreenzSDKManager sharedInstance] receiveRemoteNotificationWithData:userInfo
                                                         applicationState:application.applicationState
                                                        completionHandler:completionHandler];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    if (notificationSettings.types == UIUserNotificationTypeNone)
        [[ScreenzSDKManager sharedInstance] registerUserNotification];
    else
        [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[ScreenzSDKManager sharedInstance] registerForRemoteNotificationsWithToken:deviceToken];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    NSLog(@"Failed to get device token, error: %@", error);
    [[ScreenzSDKManager sharedInstance] failtRegisterForRemoteNotifications];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [[ScreenzSDKManager sharedInstance] processApplicaitonOpenURL:url options:options configurationFile:JSON_DATA];
}

@end
