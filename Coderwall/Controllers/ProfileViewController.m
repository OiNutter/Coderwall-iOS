//
//  ProfileViewController.m
//  Coderwall
//
//  Created by Will on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegateProtocol.h"
#import "User.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (User*) currentUser;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	User* currentUser = (User*) theDelegate.currentUser;
	return currentUser;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    User *user = [self currentUser];
    [fullName setText:[NSString stringWithFormat:user.name]];
    NSString *summaryDetails = [[NSString alloc] initWithString:@""];
    
    if(user.title != (id)[NSNull null])
        summaryDetails = [summaryDetails stringByAppendingString:user.title];
    
    if(summaryDetails.length != 0 && user.company != (id)[NSNull null] && user.company.length != 0)
        summaryDetails = [summaryDetails stringByAppendingString:@" at "];
    
    if(user.company != (id)[NSNull null])
       summaryDetails = [summaryDetails stringByAppendingString:user.company];
    
    if(summaryDetails.length != 0)
        summaryDetails = [summaryDetails stringByAppendingString:@"\n"];
    
    summaryDetails = [summaryDetails stringByAppendingString:user.location];       
    
    CGSize maximumSize = CGSizeMake(260, 80);
    UIFont *summaryFont = [UIFont fontWithName:@"Helvetica" size:14];
    CGSize summaryStringSize = [summaryDetails sizeWithFont:summaryFont 
                                               constrainedToSize:maximumSize 
                                                   lineBreakMode:summary.lineBreakMode];
    
    [summary setText:summaryDetails];
    [summary setFrame:CGRectMake(30, 265, 260, summaryStringSize.height)];
    [avatar setImage:[user getAvatar]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
