//
//  MMBeacon.m
//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.

#import "MMBeacon.h"
#import "MMBeaconAction.h"

@interface MMBeacon()

@property (nonatomic, strong) NSMutableArray *lastDistances;

@end

static float const kSignificantDistanceDiff = 0.5f;
static int const kAverageDistancesCount = 3;

@implementation MMBeacon
@synthesize major, minor;
@synthesize estimoteBeacon;
@synthesize distanceIsCalculated, averageDistance, rawDistance;
@synthesize uuid;
@synthesize beaconActions, lastDistances;

- (id) initWithData: (NSDictionary *) data
{
    self = [super init];
    
    if (self)
    {
        major = data[@"major"];
        minor = data[@"minor"];
        uuid = [[NSUUID alloc] initWithUUIDString: data[@"UUID"]];
        
        NSArray *actionsArray = data[@"actions"];
        NSMutableArray *actions = [NSMutableArray array];
        
        for (NSDictionary *action in actionsArray)
        {
            MMBeaconAction *beaconAction = [[MMBeaconAction alloc] initWithData: action];
            beaconAction.beacon = self;
            [actions addObject: beaconAction];
        }
        
        beaconActions = actions;
        rawDistance = averageDistance = -1;
        lastDistances = [NSMutableArray array];
    }
    
    return self;
}

- (void) updateBeaconDistance: (float) newDistance
{
    rawDistance = newDistance;
    [lastDistances addObject: @(newDistance)];
    
    if ([lastDistances count] > kAverageDistancesCount)
        [lastDistances removeObjectAtIndex: 0];
    
    float newAverageDistance = [[lastDistances valueForKeyPath:@"@avg.floatValue"] floatValue];
    
    if (averageDistance == -1
        || ABS(averageDistance - newAverageDistance) >= kSignificantDistanceDiff)
    {
        averageDistance = newAverageDistance;
    }
}

- (BOOL) distanceIsCalculated
{
    return averageDistance != -1;
}

- (BOOL) isEqual: (MMBeacon *) object
{
    BOOL equal = ([object isKindOfClass: [self class]]
        && [object.uuid isEqual: self.uuid]
        && [object.major isEqual: self.major]
        && [object.minor isEqual: self.minor]);
    
    return equal;
}

- (ESTBeaconRegion *) getRegion
{
    NSString *identifier = [@"region_" stringByAppendingString: [uuid UUIDString]];
    
    ESTBeaconRegion *region = [[ESTBeaconRegion alloc] initWithProximityUUID: uuid
                                                                       major: [major intValue]
                                                                       minor: [minor intValue]
                                                                  identifier: identifier];
    
    region.notifyOnEntry = region.notifyOnExit = YES;
    
    // App will be launched if app is in the background and user screen is turned on.
    // Set to YES to support background modes.
    //region.notifyEntryStateOnDisplay = NO;
    region.notifyEntryStateOnDisplay = YES;
    
    return region;
}

- (NSArray *) getActiveActionsForEntry: (BOOL) forEntry
{
    NSMutableArray *activeActions = [NSMutableArray array];
    
    for (MMBeaconAction *action in beaconActions)
    {
        if ([action isActiveForEntry: forEntry])
            [activeActions addObject: action];
    }
    
    return activeActions;
}

- (NSString *) description
{
    return [NSString stringWithFormat: @"Beacon (%@-%@) - distance: %.2f m", major, minor, averageDistance];
}

@end
