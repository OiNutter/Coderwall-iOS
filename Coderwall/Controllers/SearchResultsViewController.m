//
//  SearchResultsViewController.m
//  Coderwall
//
//  Created by Will on 02/03/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "User.h"
#import "AppDelegateProtocol.h"

@interface SearchResultsViewController ()

@end

@implementation SearchResultsViewController

- (User*) currentUser;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	User* currentUser = (User*) theDelegate.currentUser;
	return currentUser;
}

- (void) setCurrentUser:(User *) currentUser
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    [theDelegate setCurrentUser:currentUser];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Get current User
    User *user = [self currentUser];
    if(user != (id)[NSNull null] && user.userName != @"" && user.userName.length != 0)
        self.navigationItem.title = [[NSString alloc] initWithString:user.userName];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //load
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults stringForKey:@"UserName"];
    if(userName != (id)[NSNull null] && userName != @"")
        [self setCurrentUser:[[User alloc] initWithUsername:userName]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
