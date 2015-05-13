//
//  MMBeacon.h
//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESTBeacon.h"
#import "ESTBeaconRegion.h"

@interface MMBeacon : NSObject

@property (nonatomic, strong) NSNumber *major, *minor;
@property (nonatomic, strong) NSUUID *uuid;
@property (nonatomic, strong) ESTBeacon *estimoteBeacon;
@property (nonatomic) double averageDistance, rawDistance;
@property (nonatomic, strong) NSArray *beaconActions;
@property (nonatomic) BOOL distanceIsCalculated;

- (NSArray *) getActiveActionsForEntry: (BOOL) forEntry;
- (id) initWithData: (NSDictionary *) data;
- (ESTBeaconRegion *) getRegion;
- (void) updateBeaconDistance: (float) newDistance;

@end
