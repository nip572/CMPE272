//
//  MMBeaconManager.m
//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.
//

#import "MMBeaconManager.h"
#import "MMBeaconsArray.h"
#import "JSONKit.h"
#import "MMBeacon.h"
#import "NSArray+Diff.h"

NSString *const kActivateAreaAction = @"ActivateArea";
NSString *const kDeactivateAreaAction = @"DeactivateArea";
NSString *const kShowPictureAction = @"ShowPicture";
NSString *const kHidePictureAction = @"HidePicture";
NSString *const kShowURLAction = @"ShowURL";
NSString *const kHideURLAction = @"HideURL";

@interface MMBeaconManager()
{
    ESTBeaconManager *beaconManager;
    MMBeaconsArray *beacons;
    MMBeaconsArray *activeBeacons;
    NSMutableArray *rangingRegions;
    NSMutableDictionary *activeActionsDictionary;
    NSMutableDictionary *exitActionsDictionary;
}

- (void) startRanging;
- (void) stopRanging;
- (BOOL) deviceSettingsAreCorrect;

@end

@implementation MMBeaconManager
@synthesize delegate;

static MMBeaconManager *sharedInstance = nil;

#pragma mark -
#pragma mark Initialize

+ (void) initialize
{
    if (self == [MMBeaconManager class])
    {
        sharedInstance = [[self alloc] init];
    }
}

+ (MMBeaconManager *) sharedManager
{
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    
    if (self)
    {
        beaconManager = [[ESTBeaconManager alloc] init];
        beaconManager.avoidUnknownStateBeacons = YES;
        beaconManager.delegate = self;
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource: @"beacons" ofType: @"json"];
        NSString *jsonString = [[NSString alloc] initWithContentsOfFile: filePath encoding: NSUTF8StringEncoding error: nil];
        NSDictionary *jsonData = [jsonString objectFromJSONString];
        
        beacons = [[MMBeaconsArray alloc] initWithJSONDictionary: jsonData];
        activeBeacons = [[MMBeaconsArray alloc] init];
        
        rangingRegions = [NSMutableArray array];
        activeActionsDictionary = [NSMutableDictionary dictionary];
        exitActionsDictionary = [NSMutableDictionary dictionary];
    }
    
    return self;
}

#pragma mark -
#pragma mark Start monitoring && ranging

- (void) start
{
    if ([self deviceSettingsAreCorrect])
    {
        for (MMBeacon *beacon in beacons.items)
        {
            [beaconManager startMonitoringForRegion: [beacon getRegion]];
        }
        
        [self startRanging];
    }
}

- (void) startRanging
{
    for (MMBeacon *beacon in beacons.items)
    {
        ESTBeaconRegion *region = [beacon getRegion];
        [beaconManager startRangingBeaconsInRegion: region];
        [rangingRegions addObject: region];
    }
}

- (void) stopRanging
{
    for (ESTBeaconRegion *region in rangingRegions)
    {
        [beaconManager stopRangingBeaconsInRegion: region];
    }
    
    [rangingRegions removeAllObjects];
}

#pragma mark -
#pragma mark Device settings check

- (BOOL) deviceSettingsAreCorrect
{
    NSString *errorMessage = @"";
    
    if (![CLLocationManager locationServicesEnabled]
        || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        errorMessage = [errorMessage stringByAppendingString: @"Location services are turned off! Please turn them on!\n"];
    }
    
    if (![CLLocationManager isRangingAvailable])
    {
        errorMessage = [errorMessage stringByAppendingString: @"Ranging not available!\n"];
    }
    
    if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]])
    {
        errorMessage = [errorMessage stringByAppendingString: @"Beacons ranging not supported!\n"];
    }
    
    if ([errorMessage length])
    {
        [self showErrorWithMessage: errorMessage];
    }
    
    return [errorMessage length] == 0;
}

#pragma mark -
#pragma mark Background mode turned off

- (void) startBackgroundMode
{
    [self stopRanging];
}

- (void) startForegroundMode
{
    if ([self deviceSettingsAreCorrect])
    {
        [self startRanging];
    }
}

#pragma mark -
#pragma mark Error Handling

- (void) showErrorWithMessage: (NSString *) message
{
    [[[UIAlertView alloc] initWithTitle: message
                                message: nil
                               delegate: nil
                      cancelButtonTitle: @"Ok"
                      otherButtonTitles: nil] show];
}

#pragma mark -
#pragma mark ESTBeaconManagerDelegate

- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region
{
    NSLog(@"Start");
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"Are you forgetting something?";
        notification.soundName = @"Default";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        [beaconManager startRangingBeaconsInRegion: region];
    }
    
    NSLog(@"end");
}

- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region
{
    [beaconManager stopRangingBeaconsInRegion: region];
}

- (void)beaconManager:(ESTBeaconManager *)manager monitoringDidFailForRegion:(ESTBeaconRegion *)region withError:(NSError *)error
{
    [self showErrorWithMessage: error.localizedDescription];
}

- (void)beaconManager:(ESTBeaconManager *)manager rangingBeaconsDidFailForRegion:(ESTBeaconRegion *)region withError:(NSError *)error
{
    [self showErrorWithMessage: error.localizedDescription];
}

- (void)beaconManager:(ESTBeaconManager *)manager didDetermineState:(CLRegionState)state forRegion:(ESTBeaconRegion *)region
{
    if (state == CLRegionStateInside)
    {
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
        {
            [beaconManager startRangingBeaconsInRegion: region];
        }
        
    }
    else if (state == CLRegionStateOutside)
    {
        [beaconManager stopRangingBeaconsInRegion: region];
    }
}

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)estimoteBeacons inRegion:(ESTBeaconRegion *)region
{
    for (ESTBeacon *estimoteBeacon in estimoteBeacons)
    {
        if ([estimoteBeacon.distance intValue] != -1)
        {
            MMBeacon *beacon = [beacons beaconWithUUID: estimoteBeacon.proximityUUID
                                                 major: estimoteBeacon.major
                                                 minor: estimoteBeacon.minor];
            
            if (beacon)
            {
                if ([activeBeacons.items containsObject: beacon])
                    [activeBeacons.items removeObject: beacon];
                
                beacon.estimoteBeacon = estimoteBeacon;
                [beacon updateBeaconDistance: [estimoteBeacon.distance floatValue]];
                [activeBeacons.items addObject: beacon];
            }
        }
    }

    [activeBeacons sortByAverageDistance];
    
    NSLog(@"Active beacons - %@", activeBeacons);
    
    if ([activeBeacons.items count]
        && ((MMBeacon *) activeBeacons.items[0]).distanceIsCalculated)
    {
        [delegate beaconManager: self didUpdateLocationInfo: activeBeacons];
        
        NSArray *activeActions = activeActionsDictionary[region.identifier];
        NSArray *activeExitActions = exitActionsDictionary[region.identifier];
        NSArray *currentEntryBeaconsActions = [activeBeacons activeActionsForEntry: YES];
        NSArray *enteredActions = [currentEntryBeaconsActions missingObjects: activeActions];
        
        NSArray *currentExitBeaconsActions = [activeBeacons activeActionsForEntry: NO];
        
        NSArray *exitedActions = [activeExitActions missingObjects: currentExitBeaconsActions];
        
        [delegate beaconManager: self enteredActions: enteredActions];
        [delegate beaconManager: self exitedActions: exitedActions];
        
        activeActionsDictionary[region.identifier] = currentEntryBeaconsActions;
        exitActionsDictionary[region.identifier] = currentExitBeaconsActions;
     }
}


@end
