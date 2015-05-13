//
//  MMBeaconManager.h
//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.

//

#import <Foundation/Foundation.h>
#import "ESTBeaconManager.h"

@class MMBeaconManager;
@class MMBeaconsArray;

extern NSString *const kActivateAreaAction;
extern NSString *const kDeactivateAreaAction;
extern NSString *const kShowPictureAction;
extern NSString *const kHidePictureAction;
extern NSString *const kShowURLAction;
extern NSString *const kHideURLAction;

@protocol MMBeaconManagerDelegate <NSObject>

@required
- (void) beaconManager: (MMBeaconManager *) manager enteredActions: (NSArray *) actions;
- (void) beaconManager: (MMBeaconManager *) manager exitedActions: (NSArray *) actions;
- (void) beaconManager: (MMBeaconManager *) manager didUpdateLocationInfo: (MMBeaconsArray *) beacons;

@end

@interface MMBeaconManager : NSObject <ESTBeaconManagerDelegate>

@property (nonatomic, weak) id<MMBeaconManagerDelegate> delegate;

- (void) start;
+ (MMBeaconManager *) sharedManager;
- (void) startBackgroundMode;
- (void) startForegroundMode;

@end
