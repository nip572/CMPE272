//
//  MMViewController.m

//  Created by Nipun Ahuja on 12/05/15.
//  Copyright (c) 2015 swiftiostutorials.com. All rights reserved.

#import "MMViewController.h"
#import "MMBeaconsArray.h"
#import "MMBeaconAction.h"
#import "MMBeacon.h"
#import "MMURLViewController.h"
#import "MMPictureViewController.h"
#import "MMChangeView.h"
#import "ChangeView2.h"

@interface MMViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *tv1;

- (void) enteredActions: (NSArray *) actions;
- (void) exitedActions: (NSArray *) actions;
- (void) performActionWithName: (NSString *) action actionObject: (MMBeaconAction *) beaconAction;

- (void) activateAreaWithMajor: (NSNumber *) major;
- (void) deactivateAreaWithMajor: (NSNumber *) major;

- (void) hideModalController;
- (void) showPicture: (NSString *) pictureName;
- (void) showView: (NSString *) abc ;

- (void) showURL: (NSString *) urlString;
- (void) presentNavigationControllerWithViewController: (UIViewController *) controller;

@end

@implementation MMViewController
@synthesize debugInfoLabel;
@synthesize tv1;




#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
    [[MMBeaconManager sharedManager] setDelegate: self];
    
    
}

#pragma mark -
#pragma mark MMBeaconManagerDelegate

- (void) beaconManager: (MMBeaconManager *) manager enteredActions: (NSArray *) actions
{
    [self enteredActions: actions];
}

- (void) beaconManager: (MMBeaconManager *) manager exitedActions: (NSArray *) actions
{
    [self exitedActions: actions];
}

- (void) beaconManager: (MMBeaconManager *) manager didUpdateLocationInfo: (MMBeaconsArray *) beacons
{
    debugInfoLabel.text = beacons.description;
    tv1.textLabel.text = beacons.description;
    
    
 
   
}

/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [self.beaconinfo count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *SimpleIdentifier = @"SimpleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc ] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
    }
    
    cell.textLabel.text = self.beaconinfo[indexPath.row];
    return cell;
    
}*/

#pragma mark -
#pragma mark Actions Handling

- (void) enteredActions: (NSArray *) actions
{
    for (MMBeaconAction *action in actions)
    {
        [self performActionWithName: action.entryAction actionObject: action];
    }
}

- (void) exitedActions: (NSArray *) actions
{
    for (MMBeaconAction *action in actions)
    {
        [self performActionWithName: action.exitAction actionObject: action];
    }
}

- (void) performActionWithName: (NSString *) action actionObject: (MMBeaconAction *) beaconAction
{
    if ([action isEqualToString: kActivateAreaAction])
    {
        [self activateAreaWithMajor: beaconAction.beacon.major];
    }
    else if([action isEqualToString: kDeactivateAreaAction])
    {
        [self deactivateAreaWithMajor: beaconAction.beacon.major];
    }
    else if([action isEqualToString: kShowPictureAction])
    {
       // [self showPicture: beaconAction.entryObject];
        NSLog(@"reached1");
        [self showView: beaconAction.entryObject ];
    }
    else if([action isEqualToString: kShowURLAction])
    {
        [self showURL: beaconAction.entryObject];
    }
    else if([action isEqualToString: kHideURLAction]
            || [action isEqualToString: kHidePictureAction])
    {
        [self hideModalController];
    }
}

#pragma mark -
#pragma mark Areas Handling

- (void) activateAreaWithMajor: (NSNumber *) major
{
    UIView *taggedView = [self.view viewWithTag: [major integerValue]];
    
    [UIView animateWithDuration: 0.2f animations:^{
        
        taggedView.alpha = 1.0f;
        
    }];
}

- (void) deactivateAreaWithMajor: (NSNumber *) major
{
    UIView *taggedView = [self.view viewWithTag: [major integerValue]];
    
    [UIView animateWithDuration: 0.2f animations:^{
        
        taggedView.alpha = 1.0f;
        
    }];
}

#pragma mark -
#pragma mark Modal Controllers

- (void) hideModalController
{
    if (self.presentedViewController)
    {
        [self dismissViewControllerAnimated: YES completion: nil];
    }
}

- (void) showPicture: (NSString *) pictureName
{
    if (!self.presentedViewController)
    {
        MMPictureViewController *pictureController = [[MMPictureViewController alloc] init];
        pictureController.pictureName = pictureName;
        [self presentNavigationControllerWithViewController: pictureController];
    }
}

//our code

- (void) showView: (NSString *) abc
{
    NSLog(@"Hiiiiii");
    if (!self.presentedViewController)
    {
        NSLog(@"reachedhbfjhvbfhv");
       MMChangeView *arpit = [[MMChangeView alloc] init];
        
       [self presentNavigationControllerWithViewController: arpit];
        
        
    }
}
//end our code



- (void) showURL: (NSString *) urlString
{
    if (!self.presentedViewController)
    {
        //MMURLViewController *urlController = [[MMURLViewController alloc] init];
        //urlController.urlString = urlString;
        //[self presentNavigationControllerWithViewController: urlController];
        
        
        NSLog(@"bhanchod");
        ChangeView2 *arpit1 = [[ChangeView2 alloc] init];
        
        [self presentNavigationControllerWithViewController: arpit1];

        
    }
}

- (void) presentNavigationControllerWithViewController: (UIViewController *) controller
{
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: controller];
    [self presentViewController: navController animated: YES completion: nil];
}

@end
