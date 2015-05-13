//
//  ChangeView2.m

//
//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.
//

#import "ChangeView2.h"

@interface ChangeView2 ()
- (IBAction)close1:(id)sender;



@end


@implementation ChangeView2
@synthesize iv;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.title = @"Today's Offer";
    //UIImageView *Offer= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shoes_placeholder.png"] ];
    self.navigationController.navigationBarHidden = YES;
    //[Offer setImage:[UIImage imageNamed: @"MobilePortrait2.jpg"]];
    
    [iv setImage:[UIImage imageNamed: @"newjamba.jpg"]];
    
    
    
    
    
    
    //[self.view addSubview:Offer];
    
    /*self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Close"
     style: UIBarButtonItemStyleBordered
     target: self
     action: @selector(close:)];*/
}

- (void) close: (id) sender
{
    [self.presentingViewController dismissViewControllerAnimated: YES completion: nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (IBAction)close1:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated: YES completion: nil];
}
@end