//
//  MMPictureViewController.m

//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.
#import "MMPictureViewController.h"

@interface MMPictureViewController ()

@end

@implementation MMPictureViewController
@synthesize pictureImageView;
@synthesize pictureName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    pictureImageView.image = [UIImage imageNamed: pictureName];
    
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
