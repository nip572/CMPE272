//
//  NSArray+Diff.h
//  Beacons_Tutorial_iOS7
//
//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Diff)

- (NSArray *) missingObjects: (NSArray *) otherArray;

@end
