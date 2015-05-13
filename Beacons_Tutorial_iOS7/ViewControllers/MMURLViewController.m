//
//  MMURLViewController.m

//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.
//

#import "MMURLViewController.h"

@interface MMURLViewController ()

@end

@implementation MMURLViewController
@synthesize urlString, urlWebView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [urlWebView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString: urlString]]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Close"
                                                                              style: UIBarButtonItemStyleBordered
                                                                             target: self
                                                                             action: @selector(close:)];
}

- (void) close: (id) sender
{
    [self.presentingViewController dismissViewControllerAnimated: YES completion: nil];
}

@end
