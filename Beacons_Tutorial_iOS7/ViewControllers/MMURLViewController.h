//
//  MMURLViewController.h

//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.

#import <UIKit/UIKit.h>

@interface MMURLViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIWebView *urlWebView;
@property (nonatomic, strong) NSString *urlString;

@end
