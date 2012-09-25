//
//  MasterViewController.m
//  Coderwall
//
//  Created by Will on 18/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "MasterViewController.h"

#import "ImageLoader.h"
#import "UIViewController+appDelegateUser.h"
#import "User.h"


@interface MasterViewController ()
- (void)setUserName;
- (void)preloadBadges;
@end


@implementation MasterViewController


#pragma mark - Object Lifecycle

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(setUserName)
                                   name:@"UserChanged"
                                 object:nil];
        [notificationCenter addObserver:self
                               selector:@selector(preloadBadges)
                                   name:@"UserChanged"
                                 object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - UITabBarController Overrides

-(void) viewDidLoad
{
    [super viewDidLoad];

    // Add Coderwall logo to navigation bar
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        UIImage *image = [UIImage imageNamed:@"inset-logo.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        UIBarButtonItem *logoButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView];
        self.navigationItem.leftBarButtonItem = logoButtonItem;
    }
    
    self.navigationItem.rightBarButtonItem.accessibilityLabel = @"Settings";

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:nil
                                                                  action:nil];
    backButton.accessibilityLabel = @"Back";
    self.navigationItem.backBarButtonItem = backButton;

    if(!self.currentUser) {
        [self performSegueWithIdentifier:@"ShowSettings" sender:self];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    } else {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}


#pragma mark - Public Interface

- (void)showSearchResults
{
    [self performSegueWithIdentifier:@"SearchResults" sender:self];
}


#pragma mark - Internal Methods

- (void)setUserName
{
    // Get current User
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
        User *user = self.currentUser;
        if(user != (id)[NSNull null] && user.userName != @"" && user.userName.length != 0) {
            self.navigationItem.title = user.userName;
        }
    }
}

- (void)preloadBadges
{
    for (NSDictionary *badge in self.currentUser.badges) {
        NSURL *url = [NSURL URLWithString:[badge objectForKey:@"badge"]];
        [ImageLoader loadImageFromURL:url usingCache:YES];
    }
}

@end
