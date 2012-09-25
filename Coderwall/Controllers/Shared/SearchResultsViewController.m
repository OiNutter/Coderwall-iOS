//
//  SearchResultsViewController.m
//  Coderwall
//
//  Created by Will on 02/03/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "SearchResultsViewController.h"
#import "UIViewController+appDelegateUser.h"
#import "User.h"


@interface SearchResultsViewController ()

@end


@implementation SearchResultsViewController


#pragma mark - UIViewController Overrides

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.currentUser && self.currentUser.userName.length != 0) {
        self.navigationItem.title = self.currentUser.userName;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
#pragma message "FIXME - If current user is not set, -showHTTPResponseError is called when view is popped."
    NSString *userName = [userDefaults stringForKey:@"UserName"];
    [self setCurrentUser:[[User alloc] initWithUsername:userName]];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserChanged" object:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    } else {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}

@end
