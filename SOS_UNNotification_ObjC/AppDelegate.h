//
//  AppDelegate.h
//  SOS_UNNotification_ObjC
//
//  Created by Suhas Patil on 12/11/2016.
//  Copyright © 2016 Suhas Patil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong, nonatomic) CLLocationManager * locationManager;


@end

