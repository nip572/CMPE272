//
//  MMBeaconAction.m
//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.
//

#import "MMBeaconAction.h"
#import "MMBeacon.h"

@implementation MMBeaconAction
@synthesize entryAction, entryObject;
@synthesize beacon, meters;
@synthesize exitAction;
@synthesize actionID;

- (id) initWithData: (NSDictionary *) data
{
    self = [super init];
    
    if (self)
    {
        entryAction = data[@"entryAction"];
        exitAction = data[@"exitAction"];
        entryObject = data[@"entryObject"];
        meters = [data[@"meters"] floatValue];
        actionID = data[@"id"];
    }
    
    return self;
}

- (BOOL) isActiveForEntry: (BOOL) forEntry
{
    // Give 1m space for area exit
    return beacon.averageDistance <= (meters + (forEntry ? 0.0f : 1.0f));
}

- (BOOL) isEqual: (MMBeaconAction *) object
{
    BOOL equal = [object isKindOfClass: [self class]]
                && [object.actionID isEqual: self.actionID]
                && [object.beacon isEqual: self.beacon];
    
    return equal;
}

@end
