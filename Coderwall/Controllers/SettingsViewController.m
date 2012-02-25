//
//  SettingsViewController.m
//  Coderwall
//
//  Created by Will on 25/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "SettingsViewController.h"
#import "User.h"
#import "AppDelegateProtocol.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    [settingsBg setImage:[[UIImage imageNamed:@"PanelBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 15, 0)]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userNameInput setText:[userDefaults stringForKey:@"UserName"]];
    [userNameInput addTarget:self action:@selector(userNameChanged) forControlEvents:UIControlEventEditingChanged];

}

-(void) userNameChanged
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:self->userNameInput.text forKey:@"UserName"];
    [self setCurrentUser:[[User alloc] initWithUsername:self->userNameInput.text]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
