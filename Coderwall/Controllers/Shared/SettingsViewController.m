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

@property (nonatomic, strong) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, strong) IBOutlet UITextField *usernameField;

- (IBAction)userNameChanged:(id)sender;

@end


@implementation SettingsViewController

@synthesize backgroundImageView = _backgroundImageView;
@synthesize usernameField = _usernameField;


#pragma mark - UIViewController Overrides

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *backgroundImage = [UIImage imageNamed:@"PanelBg.png"];
    backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 15, 0)];
    self.backgroundImageView.image = backgroundImage;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"UserName"];
    self.usernameField.text = username;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    } else {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}


#pragma mark - Internal Methods

- (IBAction)userNameChanged:(id) sender
{
    if (self.usernameField.text.length > 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:self.usernameField.text forKey:@"UserName"];
        [userDefaults synchronize];

        [self setCurrentUser:[[User alloc] initWithUsername:self.usernameField.text]];
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
