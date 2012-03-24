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

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUserName) name:@"UserChanged" object:nil];
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    // Add Coderwall logo to navigation bar
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
        UIButton* fakeButton = (UIButton *) [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inset-logo.png"]];
        UIBarButtonItem *fakeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:fakeButton];
        self.navigationItem.leftBarButtonItem = fakeButtonItem;
    }
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    User *user = [self currentUser];
    if(user == Nil)
        [self performSegueWithIdentifier:@"ShowSettings" sender:self];
    
}

-(void) setUserName
{
     // Get current User
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
        User *user = [self currentUser];
        if(user != (id)[NSNull null] && user.userName != @"" && user.userName.length != 0)
            self.navigationItem.title = [[NSString alloc] initWithString:user.userName];
    }
}

- (void)showSearchResults
{
    [self performSegueWithIdentifier:@"SearchResults" sender:self];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    else
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
