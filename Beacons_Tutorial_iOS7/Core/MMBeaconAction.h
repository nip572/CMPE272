//
//  MMBeaconAction.h
//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.


#import <Foundation/Foundation.h>

@class MMBeacon;
@interface MMBeaconAction : NSObject

@property (nonatomic, weak) MMBeacon *beacon;
@property (nonatomic) float meters;
@property (nonatomic, strong) NSString *entryAction, *exitAction, *entryObject;
@property (nonatomic, strong) NSNumber *actionID;

- (id) initWithData: (NSDictionary *) data;
- (BOOL) isActiveForEntry: (BOOL) forEntry;

@end
