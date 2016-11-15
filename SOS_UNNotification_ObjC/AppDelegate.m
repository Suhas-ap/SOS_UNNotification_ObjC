//
//  AppDelegate.m
//  SOS_UNNotification_ObjC
//
//  Created by Suhas Patil on 12/11/2016.
//  Copyright © 2016 Suhas Patil. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // permission
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              // Enable or disable features based on authorization.
                              
                              
                          }];
    
    // delegate
    UNUserNotificationCenter* notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    notificationCenter.delegate = self;
    
    // this is for the location notification
    [self startLocationManager];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - UILocalNotification Methods

#pragma mark iOS10

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSLog(@"Presented notification in active app:%@\n",notification.request.content.userInfo);
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    // Tapped Action
    if([response.actionIdentifier isEqualToString:@"com.apple.UNNotificationDefaultActionIdentifier"]){
        
        NSLog(@"Notification tapped");

    }else
        if([response.actionIdentifier isEqualToString:@"Action1"]){
            
            // type cast response object since it is text action
            NSLog(@"Entered Text: %@", ((UNTextInputNotificationResponse *)response).userText);
        }else
            if([response.actionIdentifier isEqualToString:@"Action2"]){
                
                // click action
                NSLog(@"Action 2 is selected");
            }
    
    completionHandler();
}


#pragma mark ___________________ CLLocation Manager ___________________

- (void) startLocationManager {
    
    if(self.locationManager == nil){
        
        // for current accessing the current location
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate=self;
    }
    
    [self.locationManager startUpdatingLocation];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager performSelectorOnMainThread:@selector(startUpdatingLocation) withObject:nil waitUntilDone:YES];
}

- (void) stopLocationManager {
    
    if (self.locationManager != nil) {
        [self.locationManager stopUpdatingLocation];
        self.locationManager.delegate = nil;
    }
    self.locationManager=nil;
}

#pragma mark ___________________ User Permission For Accessing Location ___________________

- (void)requestWhenInUseAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusDenied) {
        
//        NSString *title;
//        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
//        
//        NSString *message = @"To use background location you must turn on 'While Using the App' in the Location Services Settings";
        
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        
        [self.locationManager requestWhenInUseAuthorization];
    }
}

#pragma mark ___________________ CLLocationManager Delegate Methods ___________________

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    if([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive){
        
        // user locations
        
    }else {
        
        [self stopLocationManager];
    }
}


@end
