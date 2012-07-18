//
//  SettingsViewController.m
//  Coderwall
//
//  Created by Will on 25/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "SettingsViewController.h"

#import "UIViewController+appDelegateUser.h"
#import "User.h"


@interface SettingsViewController ()
- (IBAction)userNameChanged:(id)sender;
@end


@implementation SettingsViewController


#pragma mark - UIViewController Overrides

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *backgroundImage = [UIImage imageNamed:@"PanelBg.png"];
    backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 15, 0)];
    [settingsBg setImage:backgroundImage];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userNameInput setText:[userDefaults stringForKey:@"UserName"]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    } else {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}


#pragma mark - Public Interface

- (IBAction)userNameChanged:(id) sender
{
    if (userNameInput.text.length > 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:userNameInput.text forKey:@"UserName"];
        [userDefaults synchronize];

        [self setCurrentUser:[[User alloc] initWithUsername:userNameInput.text]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserChanged" object:self];
        
    } else {
        NSString *title = NSLocalizedString(@"You must enter a username!",
                                            @"Alert title for invalid settings view input.");
        NSString *cancelTitle = NSLocalizedString(@"OK",
                                                  @"Cancel button for invalid settings view input.");

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:cancelTitle
                                              otherButtonTitles:nil];
		[alert show];
    }
}

@end
