//
//  ViewController.m
//  SOS_UNNotification_ObjC
//
//  Created by Suhas Patil on 12/11/2016.
//  Copyright © 2016 Suhas Patil. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


-(void)showAlertWithMessage:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIButton Actions

- (IBAction)intervalNotificationTapped:(id)sender {
    
    UNMutableNotificationContent* notificationContent = [[UNMutableNotificationContent alloc] init];
    
    notificationContent.title = @"Interactive Notification";
    notificationContent.body = @"Notification Body";
    notificationContent.userInfo = @{@"notificationInfo":@"Interval Notification"};
    notificationContent.sound = [UNNotificationSound defaultSound];
    
    // Provide the time interval in seconds to fire the notification
    UNTimeIntervalNotificationTrigger* notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
                                                          
    UNNotificationRequest* notificationRequest = [UNNotificationRequest requestWithIdentifier:@"intervalNotification" content:notificationContent trigger:notificationTrigger];
    
    UNUserNotificationCenter* notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    // Schedule the notification.
    [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError *error){
        
        if(!error){
            
            [self showAlertWithMessage:@"Notification added put app in background to test"];
            
        }
        
    }];
    
}


- (IBAction)dateNotificationTapped:(id)sender {
    
    UNMutableNotificationContent* notificationContent = [[UNMutableNotificationContent alloc] init];
    
    notificationContent.title = @"Date Notification";
    notificationContent.body = @"Notification Body";
    notificationContent.userInfo = @{@"notificationInfo":@"Date Notification"};
    notificationContent.sound = [UNNotificationSound soundNamed:@"sound.mp3"];
    
    // create the date component from your fire date
    NSDateComponents *dateComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate dateWithTimeIntervalSinceNow:15]];
    
    UNCalendarNotificationTrigger* notificationTrigger = [UNCalendarNotificationTrigger
                                                          triggerWithDateMatchingComponents:dateComponent repeats:NO];
    
    
    UNNotificationRequest* notificationRequest = [UNNotificationRequest requestWithIdentifier:@"dateNotification" content:notificationContent trigger:notificationTrigger];
    
    UNUserNotificationCenter* notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    // Schedule the notification.
    [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError *error){
        
        if(!error){
            
            [self showAlertWithMessage:@"Notification added put app in background to test"];
            
        }
        
    }];
    
}

- (IBAction)repeatNotificationTapped:(id)sender {
    
    UNMutableNotificationContent* notificationContent = [[UNMutableNotificationContent alloc] init];
    
    notificationContent.title = @"Repeat Notification";
    notificationContent.body = @"Notification Body";
    notificationContent.userInfo = @{@"notificationInfo":@"Repeat Notification"};
    notificationContent.sound = [UNNotificationSound defaultSound];
    
    
    // the notification gets repeated with provided interval (interval should be greater than 60)
    UNTimeIntervalNotificationTrigger* notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:60 repeats:YES]; // this will repeat notification after every 60 seconds
    
    // now for particular Date
    // the notification should gets repeated after firing for every minute
    

    
    UNNotificationRequest* notificationRequest = [UNNotificationRequest requestWithIdentifier:@"repeatNotification" content:notificationContent trigger:notificationTrigger];
    
    UNUserNotificationCenter* notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    // Schedule the notification.
    [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError *error){
        
        if(!error){
            
            [self showAlertWithMessage:@"Notification added put app in background to test"];
            
        }
        
    }];
    
    
}

- (IBAction)responsiveNotificationTapped:(id)sender {
    
    UNMutableNotificationContent* notificationContent = [[UNMutableNotificationContent alloc] init];
    
    notificationContent.title = @"Responsive Notification";
    notificationContent.body = @"Notification Body";
    notificationContent.userInfo = @{@"notificationInfo":@"Responsive Notification"};
    notificationContent.sound = [UNNotificationSound defaultSound];
    
    
    UNTextInputNotificationAction *notificationAction1 = [UNTextInputNotificationAction actionWithIdentifier:@"Action1" title:@"Text Action" options:UNNotificationActionOptionNone textInputButtonTitle:@"Done" textInputPlaceholder:@"Enter Text"];

    UNNotificationAction *notificationAction2 = [UNNotificationAction actionWithIdentifier:@"Action2" title:@"Click Action 2" options:UNNotificationActionOptionDestructive];

    
    UNNotificationCategory *notificationCategory = [UNNotificationCategory categoryWithIdentifier:@"notificationActionIdentifier" actions:@[notificationAction1,notificationAction2] intentIdentifiers:@[@"Action1", @"Action2"] options:UNNotificationCategoryOptionNone];
    
    UNUserNotificationCenter* notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    [notificationCenter setNotificationCategories:[NSSet setWithObjects:notificationCategory, nil]];
    
    notificationContent.categoryIdentifier = @"notificationActionIdentifier";

    
    UNTimeIntervalNotificationTrigger* notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
    
    UNNotificationRequest* notificationRequest = [UNNotificationRequest requestWithIdentifier:@"responsiveNotification" content:notificationContent trigger:notificationTrigger];
    
    // Schedule the notification.
    [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError *error){
        
        if(!error){
            
            [self showAlertWithMessage:@"Notification added put app in background to test"];
        }
        
    }];
    
}



- (IBAction)locationNotificationTapped:(id)sender {
    
    // Create the region for which you want to fire the notification
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(19.075984, 72.877656);
    CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:center
                                                                 radius:2000.0 identifier:@"locationNotificationRegionIdentifier"];
    region.notifyOnEntry = YES;
    region.notifyOnExit = NO;
    
    UNLocationNotificationTrigger* notificationTrigger = [UNLocationNotificationTrigger
                                              triggerWithRegion:region repeats:NO];
    
    UNMutableNotificationContent* notificationContent = [[UNMutableNotificationContent alloc] init];
    
    notificationContent.title = @"Location Notification";
    notificationContent.body = @"Notification Body";
    notificationContent.userInfo = @{@"notificationInfo":@"Location Notification"};
    notificationContent.sound = [UNNotificationSound defaultSound];
    notificationContent.launchImageName = @"apple.png";
    
    UNNotificationRequest* notificationRequest = [UNNotificationRequest requestWithIdentifier:@"locationNotification" content:notificationContent trigger:notificationTrigger];

    UNUserNotificationCenter* notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    // Schedule the notification.
    [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError *error){
        
        if(!error){
            
            [self showAlertWithMessage:@"Notification added put app in background to test"];
        }
        
    }];
    
}

    
- (IBAction)cancelNotificationTapped:(id)sender {
    
    
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];

    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Cancel Notification"
                                                                   message:@"Select which notification to cancel"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAllAction = [UIAlertAction actionWithTitle:@"All Notification "
                                                             style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
                                                                 
                                                                 [center removeAllDeliveredNotifications];
                                                                 
                                                             }];
    
    [actionSheet addAction:cancelAllAction];
    
    UIAlertAction *intervalAction = [UIAlertAction actionWithTitle:@"Interval Notification "
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              
                                                              [center removePendingNotificationRequestsWithIdentifiers:[NSArray arrayWithObject:@"intervalNotification"]];

                                                          }];
    
    [actionSheet addAction:intervalAction];
    
    
    UIAlertAction *dateAction = [UIAlertAction actionWithTitle:@"Date Notification "
                                                             style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                 
                                                                 [center removePendingNotificationRequestsWithIdentifiers:[NSArray arrayWithObject:@"dateNotification"]];
                                                                 
                                                             }];
    
    [actionSheet addAction:dateAction];
    
    UIAlertAction *repeatAction = [UIAlertAction actionWithTitle:@"Repeat Notification "
                                                             style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                 
                                                                 [center removePendingNotificationRequestsWithIdentifiers:[NSArray arrayWithObject:@"repeatNotification"]];
                                                                 
                                                             }];
    
    [actionSheet addAction:repeatAction];
    
    UIAlertAction *locationAction = [UIAlertAction actionWithTitle:@"Location Notification "
                                                             style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                 
                                                                 [center removePendingNotificationRequestsWithIdentifiers:[NSArray arrayWithObject:@"locationNotification"]];
                                                                 
                                                             }];
    
    [actionSheet addAction:locationAction];
    
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}



@end
