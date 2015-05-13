//
//  NSArray+Diff.m
//  Beacons_Tutorial_iOS7
//
//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.
//

#import "NSArray+Diff.h"

@implementation NSArray (Diff)

- (NSArray *) missingObjects: (NSArray *) otherArray
{
    NSMutableArray *missingObjects = [NSMutableArray array];
    
    for (NSObject *object in self)
    {
        if (![otherArray containsObject: object])
        {
            [missingObjects addObject: object];
        }
    }
    
    return missingObjects;
}

@end
