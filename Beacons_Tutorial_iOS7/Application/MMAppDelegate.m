//
//  MMAppDelegate.m
//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.
//

#import "MMAppDelegate.h"
#import "MMBeaconManager.h"
#import <CoreLocation/CoreLocation.h>

@interface MMAppDelegate()
@end
@interface MMAppDelegate () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation MMAppDelegate
@synthesize manager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*** Estimote iOS 8 temporary workaround ***/
    manager = [[CLLocationManager alloc] init];
    
    
    //self.locationManager = [[CLLocationManager alloc] init];
    //self.locationManager.delegate = self;
    //NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-//AFF9-25556B57FE6D"];
   
    if ([manager respondsToSelector: @selector(requestWhenInUseAuthorization)])
    {
        [manager performSelector: @selector(requestWhenInUseAuthorization)];
    }
    
    [[MMBeaconManager sharedManager] start];
    
   
    
   /* [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeNone);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        
    [application registerUserNotificationSettings:settings];*/
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeNone];
    
   
    
    return YES;
    
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    [[MMBeaconManager sharedManager] startBackgroundMode];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[MMBeaconManager sharedManager] startForegroundMode];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/*- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"Are you forgetting something?";
        notification.soundName = @"Default";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}*/


@end
