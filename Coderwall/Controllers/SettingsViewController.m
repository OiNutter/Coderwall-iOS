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

- (User*) currentUser
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

- (NSMutableArray *)refreshes
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	NSMutableArray *refreshes = (NSMutableArray*) theDelegate.refreshes;
	return refreshes;
}

- (void)setRefreshes:(NSMutableArray *)refreshes
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    [theDelegate setRefreshes:refreshes];
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
    NSLog(@"Loaded Settings");
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
}

-(void) userNameChanged:(id) sender
{
    if(self->userNameInput.text.length >0){
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:self->userNameInput.text forKey:@"UserName"];
        [userDefaults synchronize];
        [self setCurrentUser:[[User alloc] initWithUsername:self->userNameInput.text]];
        NSMutableArray *refreshes = [[NSMutableArray alloc] init];
        [refreshes addObject:@"Badges"];
        [refreshes addObject:@"Accomplishments"];
        [refreshes addObject:@"Stats"];
        [self setRefreshes:refreshes];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You must enter a username!"
														message:nil
													   delegate:nil
                                              cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
