//
//  MMViewController.h

//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMBeaconManager.h"

@interface MMViewController : UIViewController <MMBeaconManagerDelegate >

@property (nonatomic, weak) IBOutlet UILabel *debugInfoLabel;






@end
