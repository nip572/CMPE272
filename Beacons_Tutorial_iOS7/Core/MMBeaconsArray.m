//
//  MMBeaconsArray.m
//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.
//

#import "MMBeaconsArray.h"
#import "JSONKit.h"
#import "MMBeacon.h"

@implementation MMBeaconsArray
@synthesize items;

- (id) initWithJSONDictionary: (NSDictionary *) jsonDictionary
{
    self = [super init];
    
    if (self)
    {
        items = [NSMutableArray array];
        
        for (NSDictionary *beacon in jsonDictionary[@"beacons"])
        {
            MMBeacon *beaconObject = [[MMBeacon alloc] initWithData: beacon];
            [items addObject: beaconObject];
        }
    }
    
    return self;
}

- (NSArray *) activeActionsForEntry: (BOOL) forEntry
{
    NSMutableArray *allActiveActions = [NSMutableArray array];
    
    for (MMBeacon *beacon in items)
    {
        [allActiveActions addObjectsFromArray: [beacon getActiveActionsForEntry: forEntry]];
    }
    
    return allActiveActions;
}

- (void) sortByAverageDistance
{
    items = [NSMutableArray arrayWithArray: [items sortedArrayUsingComparator:
                                             ^NSComparisonResult(MMBeacon *beacon1, MMBeacon *beacon2) {
        
        if (beacon1.distanceIsCalculated && !beacon2.distanceIsCalculated)
        {
            return NSOrderedDescending;
        }
        else if (!beacon1.distanceIsCalculated && beacon2.distanceIsCalculated)
        {
            return NSOrderedAscending;
        }
        else if (beacon1.distanceIsCalculated
            && beacon2.distanceIsCalculated)
        {
            if (beacon1.averageDistance == beacon2.averageDistance)
            {
                return NSOrderedSame;
            }
            else if (beacon1.averageDistance < beacon2.averageDistance)
            {
                return NSOrderedAscending;
            }
            return NSOrderedDescending;
        }
        
        return NSOrderedSame;
    }]];
}

- (MMBeacon *) beaconWithUUID: (NSUUID *) uuid
                        major: (NSNumber *) major
                        minor: (NSNumber *) minor
{
    for (MMBeacon *beacon in items)
    {
        if ([beacon.uuid isEqual: uuid]
            && [beacon.major isEqualToNumber: major]
            && [beacon.minor isEqualToNumber: minor])
        {
            return beacon;
        }
    }
    
    return nil;
}

- (NSString *) description
{
    NSString *str = @"";
    
    for (MMBeacon *beacon in items)
    {
        str = [str stringByAppendingString: [beacon description]];
        str = [str stringByAppendingString: @"\n\n\n"];
    }
    
    return str;
}





@end
