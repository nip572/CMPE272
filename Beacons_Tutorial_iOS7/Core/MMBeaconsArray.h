//
//  MMBeaconsArray.h
//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMBeacon;

@interface MMBeaconsArray : NSObject
@property (nonatomic, strong) NSMutableArray *items;

- (id) initWithJSONDictionary: (NSDictionary *) jsonDictionary;

- (NSArray *) activeActionsForEntry: (BOOL) forEntry;
- (void) sortByAverageDistance;

- (MMBeacon *) beaconWithUUID: (NSUUID *) uuid
                        major: (NSNumber *) major
                        minor: (NSNumber *) minor;

@end
