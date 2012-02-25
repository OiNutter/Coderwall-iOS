//
//  MasterViewController.m
//  Coderwall
//
//  Created by Will on 18/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "MasterViewController.h"
#import "User.h"
#import "AppDelegateProtocol.h"

@implementation MasterViewController

- (User*) currentUser;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	User* currentUser = (User*) theDelegate.currentUser;
	return currentUser;
}

-(void) viewDidLoad
{
    
    // Add Coderwall logo to navigation bar
    UIButton* fakeButton = (UIButton *) [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inset-logo.png"]];
    UIBarButtonItem *fakeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:fakeButton];
    self.navigationItem.leftBarButtonItem = fakeButtonItem;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}

-(void) viewDidAppear:(BOOL)animated
{
    // Get current User
    User *user = [self currentUser];
    self.navigationItem.title = [[NSString alloc] initWithString:user.userName];
}

@end
